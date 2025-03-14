# /*****************************************************************************/
#  * File: runMethods.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-01-28
#  * License: [License Type]
#  * Description: This file contains the methods to run and profile the application
#  * using CUDA, Iverilog and Verilator. It provides comprehensive timing and
#  * performance analysis for each implementation.
# /*****************************************************************************/

import os
import subprocess
import time
import csv
import numpy as np
import pandas as pd
from datetime import datetime

from graph.lut2graph import Graph
from ultils.style import Mensage
from codegen.cpuConstructor import CppGenerator
from codegen.cudaConstructor import CudaGenerator
from codegen.testbenchConstructor import VerilogTestbenchGenerator

class RunMethods:
    """
    A class to manage and profile different implementations of circuit evaluation.
    Supports CUDA, Iverilog, and Verilator implementations with comprehensive
    performance analysis.
    """
    
    def __init__(self, name: str, verilog_path: str, blif_path: str, debug: bool = False):
        """
        Initialize the RunMethods class.

        Args:
            name (str): Name of the test run
            verilog_path (str): Path to Verilog files
            blif_path (str): Path to BLIF files
            debug (bool, optional): Enable debug output. Defaults to False.
        """
        self.debug = debug
        self.mensage = Mensage()

        self.graph = Graph(blif_path, verilog_path, debug=debug) # Graph object
        self.G = self.graph.graph # NetworkX graph object
        self.graph.save_graph(name) #Save the graph to a file
        self.folder_path = self.__create_folder(name)

        # Generate testbench for Verilog module
        tb_gen = VerilogTestbenchGenerator(f"{verilog_path}", debug=debug)
        tb_gen.save_testbench(f"{self.folder_path}/verilog")


        self.results_file = f"{self.folder_path}/performance_results.csv"
        self.__create_results_file()

    #=================#
    # Private methods #
    #=================#

    def __create_folder(self, folder_path: str) -> str:
        """
        Create necessary folder structure for results.

        Args:
            folder_path (str): Base path for results folders

        Returns:
            str: Path to created folder
        """
        base_path = f'{folder_path}'
        subdirs = ['cuda', 'verilog', 'verilator','cpp']
        
        for subdir in [base_path] + [f"{base_path}/{d}" for d in subdirs]:
            if not os.path.exists(subdir):
                os.makedirs(subdir)
        
        return base_path

    def __save_result(self, implementation: str, execution_time: float, 
                     throughput: float, num_operations: float = None, 
                     launches: int = None, threads_per_block: int = None, 
                     blocks_per_grid: int = None):
        """Save a single performance result to CSV file."""
        current_dir = os.getcwd()
        if current_dir != '/app':
            os.chdir('/app')
            self.__save_result(implementation, execution_time, throughput, threads_per_block, blocks_per_grid)
            os.chdir(current_dir)
            return

        with open(self.results_file, 'a') as f:
            timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            f.write(f"{timestamp},{len(self.graph.inputs)},{len(self.graph.outputs)},"
                   f"{implementation},{execution_time:.3f},"
                   f"{throughput:.2f},{num_operations or 'N/A'},"
                   f"{launches or 'N/A'},{threads_per_block or 'N/A'},"
                   f"{blocks_per_grid or 'N/A'}\n")

    def __create_results_file(self):
        """Create results CSV file with appropriate headers."""
        if not os.path.exists(self.results_file):
            with open(self.results_file, 'w') as f:
                f.write("timestamp,input_size,output_size,implementation,execution_time_ms,"
                        "throughput_combinations_per_sec,number_of_operations,launches,"
                        "threads_per_block,blocks_per_grid\n")

    def __run_cuda_profiling(self, cuda_path: str):
        """Run detailed CUDA profiling using nvprof."""
        self.mensage.info("Running CUDA profiling...")
        
        result = subprocess.run(f"ncu -c 1 {cuda_path}/circuit_evaluator",
                              shell=True, capture_output=True, text=True)
        
        with open(f"{self.folder_path}/cuda/cuda_profiling.txt", 'w') as f:
            f.write(result.stdout)
        
        if self.debug:
            print(result.stdout)
        self.mensage.success("CUDA profiling completed successfully!")

    def __parse_cuda_output(self, output: str) -> float:
        """Parse CUDA output to extract execution time."""
        lines = output.split('\n')
        for line in lines:
            if "Execution time" in line:
                return float(line.split()[-2])

        self.mensage.error("Failed to parse CUDA execution time from output")
        if self.debug:
            self.mensage.debug(f"Raw output:\n{output}")
        return 0

    def __print_analysis_results(self, implementations: dict):
        """Print comprehensive performance analysis."""
        self.mensage.info("Performance analysis results:")
        for impl, data in implementations.items():
            times = data['times']
            throughputs = data['throughputs']
            avg_time = sum(times) / len(times)
            avg_throughput = sum(throughputs) / len(throughputs)
            min_time = min(times)
            min_throughput = min(throughputs)
            max_time = max(times)
            max_throughput = max(throughputs)

            self.mensage.bold(f"{impl.upper()}:")
            print(f"  Average execution time: {avg_time:.3f} ms")
            print(f"  Average throughput: {avg_throughput:.2f} combinations/sec")
            print(f"  Min execution time: {min_time:.3f} ms")
            print(f"  Min throughput: {min_throughput:.2f} combinations/sec")
            print(f"  Max execution time: {max_time:.3f} ms")
            print(f"  Max throughput: {max_throughput:.2f} combinations/sec")

    def __calculate_throughput(self, 
                                execution_time: float,
                                blocks_per_grid: int,
                                threads_per_block: int,
                                points_per_thread: int = 1) -> dict:
        """
        Calculate throughput with detailed operation metrics.

        Args:
            execution_time (float): Total execution time in milliseconds
            blocks_per_grid (int): Number of blocks in CUDA grid
            threads_per_block (int): Number of threads per CUDA block
            points_per_thread (int, optional): Number of points per thread. Defaults to 1.

        Returns:
            dict: Comprehensive throughput metrics
        """
        # Total number of input combinations
        # 2025-02-07 11:13:00
        # The total combinations is limited to 40 to avoid overflow
        total_combinations = 2 ** len(self.graph.inputs) if len(self.graph.inputs) < 30 else 2 ** 30
        
        # Total number of threads per launch
        threads_per_launch = blocks_per_grid * threads_per_block
        
        # Total number of operations per combination
        operations_per_combination = self.graph.operations
        
        # Total number of operations across all combinations
        total_operations = threads_per_launch * operations_per_combination * points_per_thread
        
        # Convert execution time to seconds
        execution_time_seconds = execution_time / 1000.0
        
        # Calculate operations per second
        operations_per_second = total_operations / execution_time_seconds \
            if execution_time_seconds > 0 else 0

        # Calculate number of launches
        if points_per_thread > 1:
            numLaunches = 1
        else:
            numLaunches = (total_combinations + threads_per_launch - 1) / threads_per_launch;
        
        if self.debug:
            self.mensage.debug(f"Total combinations: {total_combinations}")
            self.mensage.debug(f"Operations per combination: {operations_per_combination}")
            self.mensage.debug(f"Total operations: {total_operations}")
            self.mensage.debug(f"Execution time (ms): {execution_time}")
            self.mensage.debug(f"Execution time (s): {execution_time_seconds}")
            self.mensage.debug(f"Operations per second: {operations_per_second}")
            self.mensage.debug(f"Threads per launch: {threads_per_launch}")
            self.mensage.debug(f"Number of launches: {numLaunches}")
        
        return {
            "total_combinations": total_combinations,
            "operations_per_combination": operations_per_combination,
            "total_operations": total_operations,
            "execution_time_ms": execution_time,
            "execution_time_seconds": execution_time_seconds,
            "operations_per_second": operations_per_second,
            "threads_per_launch": threads_per_launch,
            "numLaunches": numLaunches
        }
    
    #==========================================================================#
    # 2025-02-19 12:50:15
    # Generate the probability distribution of the input data, and save it to a
    # csv file, this section is temporary and will be removed in the future.
    #==========================================================================#

    def __generate_input_data(self, PATH: str, percentage: int, 
                            thread_per_block: int = 256, 
                            blocks_per_grid: int = 768):
        """Generate input data with specified percentage of 1s."""


        # Size = (num_thread, num_intermediary_nodes)
        rows = (thread_per_block * blocks_per_grid)
        cols = len(self.graph.intermediaries)

        # Calculate the number of 1s needed in each row
        num_ones = max(1,int((percentage / 100) * cols))

         # Create a matrix of zeros
        matrix = np.zeros((rows, cols), dtype=int)

        # Generate random indices for 1s in each row
        random_indices = np.argsort(np.random.rand(rows, cols), axis=1)[:, :num_ones]

        # Use advanced indexing to set the 1s
        row_indices = np.arange(rows)[:, np.newaxis]  # Row indices for each row
        matrix[row_indices, random_indices] = 1

        # Save the matrix to a CSV file
        df = pd.DataFrame(matrix)
        df.to_csv(PATH, index=False, header=False)


    #================#
    # Public methods #
    #================#

    # 2025-02-26 12:17:13:
    # Add run_cpu method to run the CPU implementation
    def run_cpu(self, cpu_path: str, num_runs: int = 10,
                method: str = '1_point', probability: int = 2,
                chunk_size: int = 4000):
        """Run and profile CPU implementation."""
        self.mensage.info("Initializing CPU execution:")
        self.mensage.info(f"• Number of runs: {num_runs}")
        self.mensage.info(f"• Method: {method}")
        self.mensage.info(f"• Probability: {probability}")
        self.mensage.info(f"• Chunk size: {chunk_size}")

        if method == 'pruned':
            self.__generate_input_data(PATH = f'{cpu_path}/p_vector.csv', 
                                    percentage=probability, 
                                    thread_per_block=256, 
                                    blocks_per_grid=768)

        # Generate CPU code
        if self.debug: self.mensage.debug(f"Generating CPU code in {cpu_path}")
        exe_path = f'{cpu_path}/circuit_evaluator.cpp'
        cpu_gen = CppGenerator(self.G,
                               max_inputs=30)
        
        exe_path = cpu_gen.run(exe_path, method=method)

        # Compile CPU code
        if self.debug: self.mensage.debug("Compiling CPU code...")
        compile_cmd = f"g++ -O3 -fopenmp -std=c++11 {exe_path} -o {cpu_path}/circuit_evaluator"

        try:
            subprocess.run(compile_cmd, shell=True, check=True)
        except subprocess.CalledProcessError:
            self.mensage.error("CPU compilation failed!")
            raise

        # Run multiple times for averaging
        self.mensage.info("Starting performance runs:")
        for i in range(num_runs):
            try:
                start_time = time.time()
                result = subprocess.run(f"{cpu_path}/circuit_evaluator", 
                                    shell=True, capture_output=True, text=True)
                
                if self.debug:
                    self.mensage.debug(f"Run output:\n")
                    print(result.stdout)
                
                execution_time = (time.time() - start_time) * 1000
                throughput = self.__calculate_throughput(execution_time=execution_time,
                                                         blocks_per_grid=1, 
                                                      threads_per_block=1024,
                                                      points_per_thread=chunk_size)
                
                self.__save_result("cpu", execution_time, 
                                   throughput['operations_per_second'],)
                
                self.mensage.success(f"Run {i+1}/{num_runs}: {execution_time:.3f} ms "
                                  f"(throughput: {throughput['operations_per_second']:.2f} combinations/sec)")

            except Exception as e:
                self.mensage.error(f"Run {i+1} failed: {str(e)}")

    def run_cuda(self, cuda_path: str, threads_per_block: int = 256, 
                blocks_per_grid: int = 768, num_runs: int = 10,
                method: str = '1_point', profile: bool = False,
                probability: int = 2):
        """Run and profile CUDA implementation."""
        self.mensage.info("Initializing CUDA execution:")
        self.mensage.info(f"• Threads per block: {threads_per_block}")
        self.mensage.info(f"• Blocks per grid: {blocks_per_grid}")
        self.mensage.info(f"• Number of runs: {num_runs}")
        self.mensage.info(f"• Method: {method}")
        self.mensage.info(f"• Profile: {profile}")
        self.mensage.info(f"• Probability: {probability}")
        

        # 2025-02-25 15:31:32: 
        # The input data is created just if the method is 'pruned', 
        # otherwise the input data is not necessary
        if method == 'pruned':
            self.__generate_input_data(PATH = f'{cuda_path}/p_vector.csv', 
                                    percentage=probability, 
                                    thread_per_block=threads_per_block, 
                                    blocks_per_grid=blocks_per_grid)

        # Generate CUDA code
        if self.debug: self.mensage.debug(f"Generating CUDA code im {cuda_path} ")
        exe_path = f'{cuda_path}/circuit_evaluator.cu'
        cuda_gen = CudaGenerator(self.G,
                                 max_inputs=15)
        
        exe_path = cuda_gen.run(exe_path, method=method, 
                                num_blocks=blocks_per_grid,
                                num_threads=threads_per_block,
                                poins_per_thread=4000,
                                p_vector_path=f'{cuda_path}/p_vector.csv',)

        # Compile CUDA code
        if self.debug: self.mensage.debug("Compiling CUDA code...")
        compile_cmd = f"nvcc -lineinfo {exe_path} -o {cuda_path}/circuit_evaluator"
        try:
            subprocess.run(compile_cmd, shell=True, check=True)
        except subprocess.CalledProcessError:
            self.mensage.error("CUDA compilation failed!")
            raise

        if profile:
            self.__run_cuda_profiling(cuda_path)

        # Run multiple times for averaging
        self.mensage.info("Starting performance runs:")
        for i in range(num_runs):
            try:
                result = subprocess.run(f"{cuda_path}/circuit_evaluator", 
                                    shell=True, capture_output=True, text=True)
                
                if self.debug:
                    self.mensage.debug(f"Run output:\n")
                    print(result.stdout)

                        
                execution_time = self.__parse_cuda_output(result.stdout)
                throughput = self.__calculate_throughput(execution_time,
                                                      blocks_per_grid, 
                                                      threads_per_block,
                                                      points_per_thread=4000 if method == 'n_points' else 1)
                
                self.__save_result("cuda", execution_time, 
                                throughput['operations_per_second'],
                                throughput['operations_per_combination'], 
                                throughput['numLaunches'], 
                                threads_per_block, blocks_per_grid)
                
                self.mensage.success(f"Run {i+1}/{num_runs}: {execution_time:.3f} ms "
                                  f"(throughput: {throughput['operations_per_second']:.2f} combinations/sec)")

            except Exception as e:
                self.mensage.error(f"Run {i+1} failed: {str(e)}")

        self.mensage.success("CUDA execution completed successfully!")

    def run_iverilog(self, verilog_path: str, exe_name: str, num_runs: int = 10):
        """Run and profile Iverilog implementation."""
        self.mensage.info("Running Iverilog simulation...")

        # Compile Verilog
        compile_cmd = f"iverilog -o {verilog_path}/{exe_name} {verilog_path}/somador.v {verilog_path}/testbench.v"
        subprocess.run(compile_cmd, shell=True, check=True)

        for i in range(num_runs):
            start_time = time.time()
            result = subprocess.run(f"vvp {verilog_path}/{exe_name}", 
                                 shell=True, capture_output=True, text=True)
            execution_time = (time.time() - start_time) * 1000

            if self.debug:
                self.mensage.debug(f"Run output:\n")
                print(result.stdout)

            num_of_combinations = 2**len(self.graph.inputs)
            throughput = num_of_combinations / (execution_time / 1000) if execution_time > 0 else 0
            self.__save_result("iverilog", execution_time, throughput)
            
            self.mensage.success(f"Run {i+1}/{num_runs}: {execution_time:.3f} ms "
                              f"(throughput: {throughput:.2f} combinations/sec)")

        self.mensage.success("Iverilog execution completed successfully!")

    def run_verilator(self, verilator_path: str, num_runs: int = 10):
        """Run Verilator implementation."""
        self.mensage.info("Initializing Verilator simulation...")

        if self.debug: self.mensage.debug("Copying Verilog files to verilator directory...")
        os.system(f"cp {self.folder_path}/verilog/*.v {verilator_path}/")

        current_dir = os.getcwd()
        os.chdir(verilator_path)

        try:
            if self.debug: self.mensage.debug("Compiling with Verilator...")
            n_threads = os.cpu_count()
            self.mensage.info(f"Using {n_threads} threads for compilation")
            compile_cmd = ("verilator -D -CFLAGS -fcoroutines --cc --main" + 
                           " --build --exe --timing -j 0 --trace -sv " +
                           "--threads " + str(n_threads) + " -Wno-fatal " + 
                           "-O3 --top-module tb_top testbench.v somador.v")
            result = subprocess.run(compile_cmd, capture_output=True, shell=True, check=True)
            
            self.mensage.info("Starting performance runs:")
            for i in range(num_runs):
                try:
                    start_time = time.time()
                    result = subprocess.run("./obj_dir/Vtb_top", 
                                        shell=True, capture_output=True, text=True)
                    
                    execution_time = (time.time() - start_time) * 1000
                    # 2025-02-19 12:49:03: The number of combinations is limited to 30 to avoid overflow
                    num_of_combinations = 2**len(self.graph.inputs) if len(self.graph.inputs) < 30 else 2**30
                    throughput = num_of_combinations / (execution_time / 1000) if execution_time > 0 else 0
                    
                    self.__save_result("verilator", execution_time, throughput)
                    
                    self.mensage.success(f"Run {i+1}/{num_runs}: {execution_time:.3f} ms "
                                      f"(throughput: {throughput:.2f} combinations/sec)")

                    if self.debug:
                        self.mensage.debug(f"Run output:\n")
                        print(result.stdout)


                except Exception as e:
                    self.mensage.error(f"Run {i+1} failed: {str(e)}")

        except subprocess.CalledProcessError as e:
            self.mensage.error(f"Verilator compilation failed! Details: {str(e)}")
            raise
        finally:
            os.chdir(current_dir)

        self.mensage.success("Verilator execution completed successfully!")

    def analyze_results(self):
        """Analyze and print comprehensive performance statistics."""
        with open(self.results_file, 'r') as f:
            reader = csv.DictReader(f)
            results = list(reader)

        implementations = {}
        for row in results:
            impl = row['implementation']
            if impl not in implementations:
                implementations[impl] = {
                    'times': [],
                    'throughputs': []
                }
            
            implementations[impl]['times'].append(float(row['execution_time_ms']))
            implementations[impl]['throughputs'].append(float(row['throughput_combinations_per_sec']))

        self.__print_analysis_results(implementations)

    def run_all(self, threads_per_block: int = 1024, blocks_per_grid: int = 1024, 
                num_runs: int = 10, profile: bool = False):
        """Run all implementations with specified parameters."""
        self.run_cuda(f'{self.folder_path}/cuda', threads_per_block, blocks_per_grid, 
                     num_runs, profile)
        self.run_iverilog(f'{self.folder_path}/verilog', 'verilog', num_runs)
        self.run_verilator(f'{self.folder_path}/verilator', num_runs)
        self.run_cpu(f'{self.folder_path}/cpp', num_runs)