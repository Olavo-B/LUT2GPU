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
from datetime import datetime

from src.lut2graph import Graph
from src.lut2graph import CudaGenerator
from src.ultils.style import Style

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
        self.graph = Graph(blif_path, verilog_path, debug=debug) # Graph object
        self.G = self.graph.graph # NetworkX graph object
        self.folder_path = self.__create_folder(name)

        # 2025-01-31 17:57:37
        # Temporary fix to get the blif and verilog path into the results folder
        # Copy blif and verilog files to results folder
        if self.debug:
            print(f"{Style.BRIGHT}{Style.OKCYAN}Copying source files to results folder...{Style.RESET}")
            
        os.system(f"cp {blif_path} {self.folder_path}")
        os.system(f"cp {verilog_path} {self.folder_path}/verilog")
        verilog_path = verilog_path.split('/')
        verilog_path = '/'.join(verilog_path[:-1])
        os.system(f"cp {verilog_path}/tb_somador.v {self.folder_path}/verilog")

        self.results_file = f"{self.folder_path}/performance_results.csv"
        self.__create_results_file()

    #====================#
    # Private Methods    #
    #====================#

    def __create_folder(self, folder_path: str) -> str:
        """
        Create necessary folder structure for results.

        Args:
            folder_path (str): Base path for results folders

        Returns:
            str: Path to created folder
        """
        base_path = f'results/{folder_path}'
        subdirs = ['cuda', 'verilog', 'verilator']
        
        for subdir in [base_path] + [f"{base_path}/{d}" for d in subdirs]:
            if not os.path.exists(subdir):
                os.makedirs(subdir)
        
        return base_path

    def __save_result(self, implementation: str, execution_time: float, 
                     throughput: float, threads_per_block: int = None, 
                     blocks_per_grid: int = None):
        """
        Save a single performance result to CSV file.

        Args:
            implementation (str): Name of the implementation (cuda/iverilog/verilator)
            execution_time (float): Execution time in milliseconds
            throughput (float): Throughput in combinations per second
            threads_per_block (int, optional): CUDA threads per block. Defaults to None.
            blocks_per_grid (int, optional): CUDA blocks per grid. Defaults to None.
        """

        # 2025-02-01 16:40:37
        # Verify if the the current directory is the same as the main app folder
        # If not, change to the main app folder, save the results and 
        # return to the original directory
        current_dir = os.getcwd()
        if current_dir != '/app':
            os.chdir('/app')
            self.__save_result(implementation, execution_time, throughput, threads_per_block, blocks_per_grid)
            os.chdir(current_dir)
            return

        with open(self.results_file, 'a') as f:
            timestamp = datetime.now().timestamp()
            f.write(f"{timestamp},{implementation},{execution_time:.3f},"
                   f"{throughput:.2f},{threads_per_block or 'N/A'},"
                   f"{blocks_per_grid or 'N/A'}\n")

    def __create_results_file(self):
        """Create results CSV file with appropriate headers if it doesn't exist."""
        if not os.path.exists(self.results_file):
            with open(self.results_file, 'w') as f:
                f.write("timestamp,implementation,execution_time_ms,throughput_combinations_per_sec,threads_per_block,blocks_per_grid\n")

    def __run_cuda_profiling(self, cuda_path: str):
        """
        Run detailed CUDA profiling using nvprof.

        Args:
            cuda_path (str): Path to CUDA source files
        """
        print(f"{Style.BRIGHT}{Style.OKCYAN}Running CUDA profiling...{Style.RESET}")
        
        result = subprocess.run(f"ncu {cuda_path}/circuit_evaluator",
                                shell=True, capture_output=True, text=True)
        
        # Save profiling output to file
        print(f"{Style.BRIGHT}{Style.OKCYAN}Saving CUDA profiling results...{Style.RESET}")
        with open(f"{self.folder_path}/cuda/cuda_profiling.txt", 'w') as f:
            f.write(result.stdout)
        
        if self.debug:
            print(result.stdout)
            print(f"{Style.BRIGHT}{Style.OKGREEN}CUDA profiling completed successfully!{Style.RESET}")

    def __parse_cuda_output(self, output: str) -> float:
        """
        Parse CUDA output to extract execution time.

        Args:
            output (str): Output from CUDA execution

        Returns:
            float: Execution time in milliseconds
        """
        lines = output.split('\n')
        for line in lines:
            if "Execution time" in line:
                return float(line.split()[-2])

        print(f"{Style.BRIGHT}{Style.FAIL}ERROR: Failed to parse CUDA execution time from output{Style.RESET}")
        if self.debug:
            print(f"{Style.WARNING}Raw output:{Style.RESET}\n{output}")
        return 0

    def __print_analysis_results(self, implementations: dict):
        """
        Print comprehensive performance analysis for all implementations.

        Args:
            implementations (dict): Dictionary containing execution times and throughputs
        """
        print(f"{Style.BRIGHT}{Style.YELLOW}Performance analysis results:{Style.RESET}")
        for impl, data in implementations.items():
            times = data['times']
            throughputs = data['throughputs']
            avg_time = sum(times) / len(times)
            avg_throughput = sum(throughputs) / len(throughputs)
            min_time = min(times)
            min_throughput = min(throughputs)
            max_time = max(times)
            max_throughput = max(throughputs)

            print(f"{impl.upper()}:")
            print(f"  Average execution time: {avg_time:.3f} ms")
            print(f"  Average throughput: {avg_throughput:.2f} combinations/sec")
            print(f"  Min execution time: {min_time:.3f} ms")
            print(f"  Min throughput: {min_throughput:.2f} combinations/sec")
            print(f"  Max execution time: {max_time:.3f} ms")
            print(f"  Max throughput: {max_throughput:.2f} combinations/sec")

    def __calculate_throughput(self, execution_time: float,
                               blocks_per_grid: int, 
                               threads_per_block: int) -> float:
        """
        Calculate throughput using execution time and number of operations.

        Args:
            execution_time (float): Execution time in milliseconds
            blocks_per_grid (int): Number of blocks in CUDA grid
            threads_per_block (int): Number of threads per CUDA block

        Returns:
            float: Throughput in combinations per second
        """
        # 2025-02-01 16:57:30
        # TODO - Validate the throughput calculation
        
        total_threads = threads_per_block * blocks_per_grid
        total_operations = total_threads * self.graph.operations
        throughput = total_operations / (execution_time / 1000) \
            if execution_time > 0 else 0
        
        return throughput

    #====================#
    # Public Methods     #
    #====================#

    def run_cuda(self, cuda_path: str, threads_per_block: int = 1024, 
                blocks_per_grid: int = 1024*1024, num_runs: int = 10, 
                profile: bool = False):
        """
        Run and profile CUDA implementation.

        Args:
            cuda_path (str): Path to CUDA source files
            threads_per_block (int, optional): Number of threads per block. Defaults to 1024.
            blocks_per_grid (int, optional): Number of blocks in grid. Defaults to 1024*1024.
            num_runs (int, optional): Number of test runs. Defaults to 10.
            profile (bool, optional): Enable detailed CUDA profiling. Defaults to False.
        """
        print(f"{Style.BRIGHT}{Style.YELLOW}Initializing CUDA execution:{Style.RESET}")
        print(f"{Style.OKCYAN}• Threads per block: {threads_per_block}")
        print(f"• Blocks per grid: {blocks_per_grid}")
        print(f"• Number of runs: {num_runs}{Style.RESET}")

        # Generate CUDA code
        if self.debug:
            print(f"{Style.OKCYAN}Generating CUDA code...{Style.RESET}")
        exe_path = f'{cuda_path}/circuit_evaluator.cu'
        cuda_gen = CudaGenerator(self.G)
        exe_path = cuda_gen.run(exe_path, threads_per_block, blocks_per_grid)

        # Compile CUDA code
        if self.debug:
            print(f"{Style.OKCYAN}Compiling CUDA code...{Style.RESET}")
        compile_cmd = f"nvcc -lineinfo {exe_path} -o {cuda_path}/circuit_evaluator"
        try:
            subprocess.run(compile_cmd, shell=True, check=True)
        except subprocess.CalledProcessError:
            print(f"{Style.BRIGHT}{Style.FAIL}ERROR: CUDA compilation failed!{Style.RESET}")
            raise

        if profile or self.debug:
            self.__run_cuda_profiling(cuda_path)

        # Run multiple times for averaging
        print(f"{Style.BRIGHT}{Style.YELLOW}Starting performance runs:{Style.RESET}")
        for i in range(num_runs):
            try:
                result = subprocess.run(f"{cuda_path}/circuit_evaluator", 
                                    shell=True, 
                                    capture_output=True, 
                                    text=True)
                
                if self.debug:
                    print(f"{Style.OKCYAN}Run output:{Style.RESET}\n{result.stdout}")
                        
                execution_time = self.__parse_cuda_output(result.stdout)
                throughput = self.__calculate_throughput(execution_time,
                                                      blocks_per_grid, 
                                                      threads_per_block)
                
                self.__save_result("cuda", execution_time, throughput, 
                                threads_per_block, blocks_per_grid)
                
                print(f"{Style.OKGREEN}Run {i+1}/{num_runs}: {execution_time:.3f} ms "
                      f"(throughput: {throughput:.2f} combinations/sec){Style.RESET}")

            except Exception as e:
                print(f"{Style.BRIGHT}{Style.FAIL}ERROR: Run {i+1} failed: {str(e)}{Style.RESET}")

        print(f"{Style.BRIGHT}{Style.OKGREEN}✓ CUDA execution completed successfully!{Style.RESET}")

    def run_iverilog(self, verilog_path: str, exe_name: str, num_runs: int = 10):
        """
        Run and profile Iverilog implementation.

        Args:
            verilog_path (str): Path to Verilog source files
            exe_name (str): Name for compiled executable
            num_runs (int, optional): Number of test runs. Defaults to 10.
        """
        print(f"{Style.BRIGHT}{Style.YELLOW}Running Iverilog simulation...{Style.RESET}")

        # Compile Verilog
        compile_cmd = f"iverilog -o {verilog_path}/{exe_name} {verilog_path}/somador.v {verilog_path}/tb_somador.v"
        subprocess.run(compile_cmd, shell=True, check=True)

        for i in range(num_runs):
            start_time = time.time()
            result = subprocess.run(f"vvp {verilog_path}/{exe_name}",shell=True, 
                                    capture_output=True, 
                                    text=True)
            execution_time = (time.time() - start_time) * 1000

            if self.debug:
                print(f"{Style.OKCYAN}Run output:{Style.RESET}\n{result.stdout}")

            # 2025-02-01 13:22:10
            # thorughput = (number of combinations) / execution_time
            num_of_combinations = 2**len(self.graph.inputs)
            throughput = num_of_combinations / (execution_time / 1000) if execution_time > 0 else 0
            self.__save_result("iverilog", execution_time, throughput)
            
            print(f"{Style.OKGREEN}Run {i+1}/{num_runs}: {execution_time:.3f} ms "
                  f"(throughput: {throughput:.2f} combinations/sec){Style.RESET}")

        print(f"{Style.BRIGHT}{Style.OKGREEN}✓ Iverilog execution completed successfully!{Style.RESET}")

    
    def run_verilator(self, verilator_path: str, num_runs: int = 10):
        """Run Verilator implementation with enhanced error handling"""
        print(f"{Style.BRIGHT}{Style.YELLOW}Initializing Verilator simulation...{Style.RESET}")

        if self.debug:
            print(f"{Style.OKCYAN}Copying Verilog files to verilator directory...{Style.RESET}")
        os.system(f"cp {self.folder_path}/verilog/*.v {verilator_path}/")

        current_dir = os.getcwd()
        os.chdir(verilator_path)

        try:
            if self.debug:
                print(f"{Style.OKCYAN}Compiling with Verilator...{Style.RESET}")
            compile_cmd = "verilator -D -CFLAGS -fcoroutines --cc --main --build --exe --timing --trace --top-module tb_top *.v"
            result = subprocess.run(compile_cmd, capture_output=True, shell=True, check=True)
            
            print(f"{Style.BRIGHT}{Style.YELLOW}Starting performance runs:{Style.RESET}")
            for i in range(num_runs):
                try:
                    start_time = time.time()
                    result = subprocess.run("./obj_dir/Vtb_top", 
                                        shell=True,
                                        capture_output=True,
                                        text=True)
                    
                    execution_time = (time.time() - start_time) * 1000
                    num_of_combinations = 2**len(self.graph.inputs)
                    throughput = num_of_combinations / (execution_time / 1000) if execution_time > 0 else 0
                    
                    self.__save_result("verilator", execution_time, throughput)
                    
                    print(f"{Style.OKGREEN}Run {i+1}/{num_runs}: {execution_time:.3f} ms "
                          f"(throughput: {throughput:.2f} combinations/sec){Style.RESET}")

                    if self.debug:
                        print(f"{Style.OKCYAN}Run output:{Style.RESET}\n{result.stdout}")

                except Exception as e:
                    print(f"{Style.BRIGHT}{Style.FAIL}ERROR: Run {i+1} failed: {str(e)}{Style.RESET}")

        except subprocess.CalledProcessError as e:
            print(f"{Style.BRIGHT}{Style.FAIL}ERROR: Verilator compilation failed!")
            print(f"Details: {str(e)}{Style.RESET}")
            raise
        finally:
            os.chdir(current_dir)

        print(f"{Style.BRIGHT}{Style.OKGREEN}✓ Verilator execution completed successfully!{Style.RESET}")

    def analyze_results(self):
        """
        Analyze and print comprehensive performance statistics for all implementations.
        Calculates average, minimum, and maximum execution times and throughput.
        """
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
        """
        Run all implementations with specified parameters.

        Args:
            threads_per_block (int, optional): CUDA threads per block. Defaults to 1024.
            blocks_per_grid (int, optional): CUDA blocks per grid. Defaults to 1024*1024.
            num_runs (int, optional): Number of test runs. Defaults to 10.
            profile (bool, optional): Enable CUDA profiling. Defaults to False.
        """
        self.run_cuda(f'{self.folder_path}/cuda', threads_per_block, blocks_per_grid, 
                     num_runs, profile)
        self.run_iverilog(f'{self.folder_path}/verilog', 'verilog', num_runs)
        self.run_verilator(f'{self.folder_path}/verilator', num_runs)
