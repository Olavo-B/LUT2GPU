# /*****************************************************************************/
#  * File: lut2graph.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-01-27
#  * License: [License Type]
#  * Description: This script converts a LUT graph to a graph using netwowrkx 
#  * library.
# /*****************************************************************************/


import matplotlib.pyplot as plt
from itertools import product
import networkx as nx
import os
import re


from src.ultils.style import Style, Mensage


class Graph():
    """
    Class that represents a LUT graph.

    Attributes:
    - G: nx.DiGraph
        A directed graph representing the LUT.
    - debug: bool
        A flag that indicates if debug messages should be printed.
    """
    def __init__(self, blif_path:str, verilog_path:str, debug:bool = False):
        self.G = nx.DiGraph()
        self.debug = debug

        self.__parse_blif(blif_path, verilog_path)

    
    def __getitem__(self, node):
        return self.G[node]
    
    #====================#
    # Getters and Setters#
    #====================#

    @property
    def graph(self):
        return self.G
    
    @property
    def operations(self):
        return sum([data.get('operations', 0) for node, data in self.G.nodes(data=True)])
    
    @property
    def inputs(self):
        return [node for node, data in self.G.nodes(data=True) if data.get('type') == 'input']
    
    @property
    def outputs(self):
        return [node for node, data in self.G.nodes(data=True) if data.get('type') == 'output']
    
    #====================#
    #  Private Methods   #
    #====================#

    def __binary_to_decimal(self, binary_str: str) -> int:
        """
        Convert a binary string to a decimal integer.

        Args:
        ------

        - binary_str: str
            A binary string.
        
        Returns:
        ------

        - decimal: int
            A decimal integer.

        Example:
        ------

        binary_str = "1011"
        decimal = 11

        """
        return int(binary_str, 2)


    def __pla_to_binary_vector(self, pla_table: list[dict], num_vars: int) -> list:
        """
        Convert a PLA table to a binary vector.

        Args:
        ------
        - pla_table: list
            A list of dictionaries representing the PLA table.
        - num_vars: int
            The number of variables in the truth table.
        
        Returns:
        ------
        - binary_vector: list
            A list of integers representing the binary vector.

        Example:
        ------

        pla_table = [
            {"input": "00-", "output": "1"},
            {"input": "01-", "output": "0"},
            {"input": "1--", "output": "1"}
        ]

        binary_vector = [1, 0, 1, 1]
        """
        vector_size = 2 ** num_vars
        binary_vector = [0 if int(pla_table[0]['output'])==1 else 1] * vector_size

        
        
        for entry in pla_table:
            pattern, output = ''.join(entry["input"]), entry["output"]  # Garante que input seja tratado como string
            positions = [i for i, char in enumerate(pattern) if char == '-']
            base_pattern = list(pattern)
            
            for replacements in product('01', repeat=len(positions)):
                temp_pattern = base_pattern[:]
                for pos, char in zip(positions, replacements):
                    temp_pattern[pos] = char
                expanded_pattern = ''.join(temp_pattern)
                try:
                    index = int(expanded_pattern, 2)  # Garante que a ordem dos bits seja respeitada
                    binary_vector[index] = int(output)  # Armazena o valor correto
                except ValueError:
                    print(f"Erro ao converter: {expanded_pattern}")
        
        binary_vector.reverse()
        return binary_vector
    

    def __extract_equations(self, verilog_path:str) -> dict:
        """
        Extract the equations from a Verilog file.

        Args:
        ------
        - verilog_path: str
            The path to the Verilog file.
        
        Returns:
        ------
        - equations: dict
            A dictionary containing the equations.
        
        Example:
        ------
        verilog_content = ```
        module somador(
            input a,
            input b,
            output z
        );
        assign z = a ^ b;
        endmodule
        ```
        equations = {"z": "a ^ b"}

        """
        with open(verilog_path, 'r') as file:
            verilog_content = file.read()
        

        equations = {}
        lines = verilog_content.split('\n')
        for line in lines:
            stripped_line = line.strip()
            if stripped_line.startswith('assign') and '=' in stripped_line:
                # Split into variable and equation parts
                var_part, eq_part = stripped_line.split('=', 1)
                var_name = var_part.replace('assign', '').strip()
                # Clean the equation part
                equation = eq_part.replace(';', '').strip()

                # 2025-02-01 12:31:36
                # Count all types of operations
                operation_count = (
                    equation.count('&') +  # Bitwise AND
                    equation.count('|') +  # Bitwise OR
                    equation.count('~') +  # Bitwise NOT
                    equation.count('^') +  # XOR
                    equation.count('+') +  # Addition
                    equation.count('-') +  # Subtraction
                    equation.count('*') +  # Multiplication
                    equation.count('/') +  # Division
                    equation.count('%') +  # Modulus
                    equation.count('==') + # Equality
                    equation.count('!=') + # Inequality
                    equation.count('>') +  # Greater than
                    equation.count('<') +  # Less than
                    equation.count('>=') + # Greater than or equal
                    equation.count('<=') + # Less than or equal
                    equation.count('<<') + # Left shift
                    equation.count('>>') + # Right shift
                    equation.count('?')    # Ternary operator
                )

                # 2025-01-28 19:43:23
                # Change Verilog sintax to C/C++ sintax
                equation = equation.replace('^', '^')
                equation = equation.replace('&', '&&')
                equation = equation.replace('|', '||')
                equation = equation.replace('~', '!')


                # Store the equation and the operation count
                equations[var_name] = {
                    "equation": equation,
                    "operations": operation_count
                }

        return equations


    def __rename_ports(self, input_file, output_file, file_type='blif'):
        """
        Rename input, output, and internal port names in BLIF or Verilog files, 
        removing brackets, zero-padding single-digit indices.
        """
        with open(input_file, 'r') as f:
            content = f.read()
        
        # Remove line continuation backslashes
        content = re.sub(r'\\\n\s*', '', content)
        
        # Replace port references with brackets
        content = re.sub(r'(\\?[a-zA-Z]+)\[(\d+)\]', 
                        lambda m: f"{m.group(1).replace('\\', '')}{'0' if len(m.group(2)) == 1 else ''}{m.group(2)}", 
                        content)
        
        with open(output_file, 'w') as f:
            f.write(content)


    def __parse_blif(self, blif_path:str, verilog_path:str) -> None:
        """
        Parse a BLIF file and create a graph.

        Args:
        ------
        - blif_path: str
            The path to the BLIF file.
        - verilog_path: str
            The path to the Verilog file.
        
        Returns:
        -------
        - None

        """
    
        # 2025-02-03 13:22:03
        # Rename ports in BLIF and Verilog files
        self.__rename_ports(blif_path, blif_path)
        self.__rename_ports(verilog_path, verilog_path, file_type='verilog')
    
        with open(blif_path, 'r') as file:
            lines = file.readlines()



        equations = self.__extract_equations(verilog_path)
        
        inputs, outputs = [], []
        parsing_names = False
        current_node = None
        node_data = {}
        input_order = {}
        
        for line in lines:
            tokens = line.strip().split()

            if len(tokens) == 0:
                continue
            elif tokens[0] == ".inputs":
                inputs = tokens[1:]
                self.G.add_nodes_from(inputs, type="input")
            elif tokens[0] == ".outputs":
                outputs = tokens[1:]
                self.G.add_nodes_from(outputs, type="output")
            elif tokens[0] == ".names":

                # 2025-02-03 13:22:03
                # Continue if the node is not in the equations
                if tokens[-1] not in equations.keys():
                    continue

                parsing_names = True
                current_node = tokens[-1]
                dependencies = tokens[1:-1]

                for dep in dependencies:
                    if dep not in self.G.nodes():
                        self.G.add_node(dep, type="intermediary", input_order=[], truth_value=None)
                    self.G.add_edge(dep, current_node)
        
                node_data[current_node] = []
    
                input_order[current_node] = dependencies

                self.G.nodes[current_node]['input_order'] = dependencies
                self.G.nodes[current_node]['truth_value'] = None

            elif parsing_names and current_node is not None and len(tokens) > 1:
                input_values = tokens[:-1]
                output_value = tokens[-1]
                node_data[current_node].append({"input": input_values, "output": output_value})
            else:
                parsing_names = False
        
        for node, partial_truth_table in node_data.items():
            num_vars = len(input_order[node])
            full_truth_table = self.__pla_to_binary_vector(partial_truth_table, num_vars)
            self.G.nodes[node]['truth_value'] = self.__binary_to_decimal("".join(map(str, full_truth_table)))
            if node in equations.keys():
                self.G.nodes[node]['equation'] = equations[node]['equation']
                self.G.nodes[node]['operations'] = equations[node]['operations']
        # if self.debug:
        #     import pprint 
        #     pprint.pprint(list(self.G.nodes(data=True)))

class CudaGenerator():
    """
    Class that generates CUDA code for a LUT graph.

    Attributes:
    - G: nx.DiGraph
        A directed graph representing the LUT.
    - inputs: list
        A list of input nodes.
    - outputs: list
        A list of output nodes.
    - num_inputs: int
        The number of input nodes.
    - num_outputs: int
        The number of output nodes.
    - ordered_nodes: list
        A list of nodes in topological order.
    - cuda_code: str
        The generated CUDA code.
    """
    def __init__(self, graph:nx.DiGraph):
        self.G = graph
        self.inputs = [node for node, data in self.G.nodes(data=True) if data.get('type') == 'input']
        self.outputs = [node for node, data in self.G.nodes(data=True) if data.get('type') == 'output']
        self.num_inputs = len(self.inputs)
        self.num_outputs = len(self.outputs)

        self.ordered_nodes = list(nx.topological_sort(self.G))
        self.cuda_code = ""
        
        # Calculate effective number of inputs (limited to 64 bits)
        self.effective_inputs = min(self.num_inputs, 40)
        # Calculate effective number of outputs (limited to 64 bits)
        self.effective_outputs = min(self.num_outputs, 40)
        self.mensage = Mensage()
        
        if self.num_inputs > 64:
            self.mensage.warning(f"Number of inputs ({self.num_inputs}) exceeds 64 bits. Only using least significant 64 bits.")
        if self.num_outputs > 64:
            self.mensage.warning(f"Number of outputs ({self.num_outputs}) exceeds 64 bits. Only storing least significant 64 bits.")

    
    def __str__(self):
        return self.cuda_code
    
    def __repr__(self):
        return self.cuda_code
    


    #====================#
    # Getters and Setters#
    #====================#


    #====================#
    #  Private Methods   #
    #====================#
    
    def __generate_cuda_header(self) -> None:
        """Original header generation method with 64-bit types"""
        self.cuda_code = """
#include <stdio.h>
#include <cuda_runtime.h>
#include <stdlib.h>

// Utility function to check CUDA errors
#define CHECK_CUDA_ERROR(call) { \\
    cudaError_t err = call; \\
    if (err != cudaSuccess) { \\
        printf("CUDA error: %s\\n", cudaGetErrorString(err)); \\
        exit(1); \\
    } \\
}
        """
    def __generate_variable_declarations(self) -> str:
        """Generate variable declarations using unsigned long long for large circuits"""
        code = "\n        // Initialize all variables\n"
        all_nodes = set(self.G.nodes())
        for node in all_nodes:
            code += f"    unsigned long long {node} = 0;\n"
        return code

    def __generate_input_assignments(self) -> str:
        """Generate input assignments limited to 64 bits"""
        code = "\n        // Set input values\n"
        for i, input_var in enumerate(reversed(self.inputs[:self.effective_inputs])):
            code += f"        {input_var} = (x >> {i}) & 1ULL;\n"
        # Set remaining inputs to 0
        for input_var in reversed(self.inputs[self.effective_inputs:]):
            code += f"        {input_var} = 0;\n"
        return code

    def __generate_circuit_evaluation(self) -> str:
        """Generate circuit evaluation code"""
        code = "\n        // Evaluate circuit in topological order\n"
        for node in self.ordered_nodes:
            if node not in self.inputs:
                equation = self.G.nodes[node].get('equation')
                if equation is not None:
                    code += f"        {node} = ({equation});\n"
        return code

    def __generate_output_assignments(self) -> str:
        """Generate output assignments limited to 64 bits"""
        code = "\n        // Store result for this point\n"
        code += "        result = 0;\n"
        for i, output in enumerate(self.outputs[:self.effective_outputs]):
            code += f"        result |= ((unsigned long long){output} & 1ULL) << {i};\n"
        return code

    def __generate_n_points_kernel(self, points_per_thread: int = 10000) -> None:
        """Generate CUDA kernel for processing N points per thread with 64-bit limitation"""
        self.cuda_code += f"""
    __global__ void evaluate_circuit(unsigned long long *output, unsigned long long start_idx, unsigned long long end_idx, int points_per_thread) {{
        unsigned long long base_idx = blockIdx.x * blockDim.x + threadIdx.x;
        {self.__generate_variable_declarations()}
        unsigned long long result = 0;


        
        // Each thread processes points_per_thread points
        for (int point = 0; point < points_per_thread; point++) {{
            unsigned long long idx = base_idx * points_per_thread + point + start_idx;
            if (idx >= end_idx) return;
            
            unsigned long long x = idx;
            {self.__generate_input_assignments()}
            {self.__generate_circuit_evaluation()}
            {self.__generate_output_assignments()}
            
            // Store the result in the correct position
            output[base_idx * points_per_thread + point] = result;
        }}
    }}
    """

    def __generate_n_points_main(self, threads_per_block: int = 1024, points_per_thread: int = 10000) -> None:
        """Generate main function with N points per thread support and 64-bit limitation"""
        self.cuda_code += f"""
    int main() {{
        const unsigned int num_inputs = {self.effective_inputs};  // Limited to 64 bits
        const unsigned long long num_combinations = 1ULL << num_inputs;
        
        const int threadsPerBlock = {threads_per_block};
        const int numSMs = 24;  // For RTX 4060
        const int blocksPerSM = 32;
        const int optimalBlocks = numSMs * blocksPerSM;
        const int pointsPerThread = {points_per_thread};
        
        const unsigned long long threadsPerLaunch = (unsigned long long)optimalBlocks * threadsPerBlock;
        const unsigned long long pointsPerLaunch = threadsPerLaunch * pointsPerThread;
        const unsigned long long numLaunches = (num_combinations + pointsPerLaunch - 1) / pointsPerLaunch;
        // const unsigned long long numLaunches = 1;
        
        printf("Using %d least significant input bits\\n", num_inputs);
        printf("Using %d least significant output bits\\n", {self.effective_outputs});
        printf("Points per thread: %d\\n", pointsPerThread);
        printf("Threads per block: %d\\n", threadsPerBlock);
        printf("Blocks per grid: %d\\n", optimalBlocks);
        printf("Total points per launch: %llu\\n", pointsPerLaunch);
        printf("Required launches: %llu\\n\\n", numLaunches);
        
        cudaEvent_t start, stop;
        CHECK_CUDA_ERROR(cudaEventCreate(&start));
        CHECK_CUDA_ERROR(cudaEventCreate(&stop));
        
        const size_t outputSizePerLaunch = pointsPerLaunch * sizeof(unsigned long long);
        unsigned long long *h_output = (unsigned long long*)malloc(outputSizePerLaunch);
        if (!h_output) {{
            printf("Error: Host memory allocation failed\\n");
            return 1;
        }}
        
        unsigned long long *d_output;
        CHECK_CUDA_ERROR(cudaMalloc(&d_output, outputSizePerLaunch));
        
        CHECK_CUDA_ERROR(cudaEventRecord(start));
        
        for (unsigned long long i = 0; i < numLaunches; i++) {{
            unsigned long long start_idx = i * pointsPerLaunch;
            unsigned long long end_idx = (start_idx + pointsPerLaunch < num_combinations) ? 
                                       start_idx + pointsPerLaunch : num_combinations;
            
            CHECK_CUDA_ERROR(cudaMemset(d_output, 0, outputSizePerLaunch));
            
            evaluate_circuit<<<optimalBlocks, threadsPerBlock>>>(
                d_output, start_idx, end_idx, pointsPerThread
            );
            
            cudaError_t kernelError = cudaGetLastError();
            if (kernelError != cudaSuccess) {{
                printf("Kernel error: %s\\n", cudaGetErrorString(kernelError));
                cudaFree(d_output);
                free(h_output);
                return 1;
            }}
            
            CHECK_CUDA_ERROR(cudaMemcpy(h_output, d_output, outputSizePerLaunch, cudaMemcpyDeviceToHost));
        }}
        
        CHECK_CUDA_ERROR(cudaEventRecord(stop));
        CHECK_CUDA_ERROR(cudaEventSynchronize(stop));
        
        float milliseconds = 0;
        CHECK_CUDA_ERROR(cudaEventElapsedTime(&milliseconds, start, stop));
        printf("GPU Execution time: %.3f milliseconds\\n", milliseconds);
        
        free(h_output);
        CHECK_CUDA_ERROR(cudaFree(d_output));
        CHECK_CUDA_ERROR(cudaEventDestroy(start));
        CHECK_CUDA_ERROR(cudaEventDestroy(stop));
        
        return 0;
    }}
    """

    def __generate_cuda_kernel(self) -> None:
        """
        Create the CUDA kernel for the LUT evaluation.

        Args:
        ------
        - None

        Returns:
        ------
        - None
        """

        self.cuda_code += """
    __global__ void evaluate_circuit(int *output, unsigned long long start_idx, unsigned long long end_idx) {
        unsigned long long idx = blockIdx.x * blockDim.x + threadIdx.x + start_idx;

        if (idx < end_idx) {
            unsigned long int x = idx;
            """
        # Initialize all variables to 0
        all_nodes = set(self.G.nodes())
        self.cuda_code += "\n        // Initialize all variables\n"
        for node in all_nodes:
            self.cuda_code += f"    unsigned long long int {node};\n"
        
        self.cuda_code += "\n        // Set input values\n"
        # Input variable assignments
        for i, input_var in enumerate(reversed(self.inputs)):
            self.cuda_code += f"        {input_var} = (x >> {i}) & 1;\n"
        
        self.cuda_code += "\n        // Evaluate circuit in topological order\n"
        
        # Generate equations in topological order
        for node in self.ordered_nodes:
            if node not in self.inputs:  # Skip input nodes
                equation = self.G.nodes[node].get('equation')
                if equation is not None:
                    self.cuda_code += f"        {node} = ({equation});\n"
        
        self.cuda_code += "\n        // Combine outputs into a single integer\n"
        # Adjust output indexing to use relative index within the launch
        self.cuda_code += "        output[idx - start_idx] = 0;\n"
        
        # Combine outputs
        for i, output in enumerate(self.outputs):
            self.cuda_code += f"        output[idx - start_idx] |= ({output} << {i});\n"

        
        self.cuda_code += "    }\n}\n\n"

    def __generate_cuda_main(self, threads_per_block:int = 256) -> None:
        """
        Create the main function with improved memory management and error handling.
        """
        self.cuda_code += f"""
    int main() {{
        // Calculate number of input combinations
        const unsigned int num_inputs = {self.num_inputs};
        const unsigned long long num_combinations = 1ULL << num_inputs;
        
        const int threadsPerBlock = {threads_per_block};
        const int numSMs = 24;  // For RTX 4060
        const int blocksPerSM = 32;
        const int optimalBlocks = numSMs * blocksPerSM;  // 768 blocks
        
        // Calculate required kernel launches
        const unsigned long long threadsPerLaunch = (unsigned long long)optimalBlocks * threadsPerBlock;
        const unsigned long long numLaunches = (num_combinations + threadsPerLaunch - 1) / threadsPerLaunch;
        
        printf("Threads per block: %d\\n", threadsPerBlock);
        printf("Blocks per grid: %d\\n", optimalBlocks);
        printf("Total threads per launch: %llu\\n", threadsPerLaunch);
        printf("Required launches: %llu\\n\\n", numLaunches);
        
        // Allocate memory and set up timing
        cudaEvent_t start, stop;
        CHECK_CUDA_ERROR(cudaEventCreate(&start));
        CHECK_CUDA_ERROR(cudaEventCreate(&stop));
        
        // Allocate host and device memory for each launch
        const size_t outputSizePerLaunch = threadsPerLaunch * sizeof(int);
        int *h_output = NULL;
        int *d_output = NULL;
        
        h_output = (int*)malloc(outputSizePerLaunch);
        if (!h_output) {{
            printf("Error: Host memory allocation failed\\n");
            return 1;
        }}
        
        CHECK_CUDA_ERROR(cudaMalloc(&d_output, outputSizePerLaunch));
        
        // Record start time
        CHECK_CUDA_ERROR(cudaEventRecord(start));
        
        // Process all combinations in chunks
        for (unsigned long long i = 0; i < numLaunches; i++) {{
            unsigned long long start_idx = i * threadsPerLaunch;
            unsigned long long end_idx = start_idx + threadsPerLaunch;
            if (end_idx > num_combinations) {{
                end_idx = num_combinations;
            }}
            
            // Clear device memory before kernel launch
            CHECK_CUDA_ERROR(cudaMemset(d_output, 0, outputSizePerLaunch));
            
            // Launch kernel with start and end indices
            evaluate_circuit<<<optimalBlocks, threadsPerBlock>>>(d_output, start_idx, end_idx);
            
            // Check for kernel launch errors
            cudaError_t kernelLaunchError = cudaGetLastError();
            if (kernelLaunchError != cudaSuccess) {{
                printf("Kernel launch error: %s\\n", cudaGetErrorString(kernelLaunchError));
                cudaFree(d_output);
                free(h_output);
                return 1;
            }}
            
            // Copy results for this launch
            CHECK_CUDA_ERROR(cudaMemcpy(h_output, d_output, outputSizePerLaunch, cudaMemcpyDeviceToHost));
            
            // Optional: Process or save h_output here if needed
        }}
        
        // Record stop time and calculate elapsed time
        CHECK_CUDA_ERROR(cudaEventRecord(stop));
        CHECK_CUDA_ERROR(cudaEventSynchronize(stop));
        
        float milliseconds = 0;
        CHECK_CUDA_ERROR(cudaEventElapsedTime(&milliseconds, start, stop));
        printf("GPU Execution time: %.3f milliseconds\\n", milliseconds);
        
        // Cleanup
        CHECK_CUDA_ERROR(cudaEventDestroy(start));
        CHECK_CUDA_ERROR(cudaEventDestroy(stop));
        free(h_output);
        CHECK_CUDA_ERROR(cudaFree(d_output));
        
        return 0;
    }}
    """

    #====================#
    # Public Methods     #
    #====================#

    def generate_n_points_code(self, threads_per_block: int = 1024, points_per_thread: int = 10000) -> str:
        """Generate CUDA code with N points per thread support and 64-bit limitation"""
        self.__generate_cuda_header()
        self.__generate_n_points_kernel(points_per_thread)
        self.__generate_n_points_main(threads_per_block, points_per_thread)
        return self.cuda_code

    def generate_code(self, num_blocks:int  = 1024, num_threads:int = 1024) -> str:
        """
        Generate the CUDA code for the LUT graph.

        Args:
        ------
        - num_blocks: int
            The number of blocks to use.
        - num_threads: int
            The number of threads per block.

        Returns:
        ------
        - cuda_code: str
            The generated CUDA code.
        """

        self.__generate_cuda_header()
        self.__generate_cuda_kernel()
        self.__generate_cuda_main(num_threads)
        return self.cuda_code
    
    def write_code(self, file_path:str) -> str:
        """
        Write the CUDA code to a file.

        Args:
        ------
        - file_path: str
            The path to the file.
        
        Returns:
        ------
        - file_path: str
            The path to the file.
        
        """

        if not os.path.exists(os.path.dirname(file_path)):
            os.makedirs(os.path.dirname(file_path))


        with open(file_path, 'w') as file:
            file.write(self.cuda_code)
        return file_path
    
    def compile_code(self, file_path:str) -> str:
        """
        Compile the CUDA code.

        Args:
        ------
        - file_path: str
            The path to the file.
        
        Returns:
        ------
        - executable: str
            The name of the executable.
        """

        # Get folder
        folder = os.path.dirname(file_path)

        os.system(f"nvcc {file_path} -o {folder}/circuit")
        return f"{folder}/circuit"
    
    def run(self, file_path:str ,
            method:str = "1_point", 
            num_blocks:int = 1024, 
            num_threads:int = 1024, 
            poins_per_thread:int = 10000) -> str:
        """
        Run the CUDA code.

        Args:
        ------
        - file_path: str
            The path to the file.
        - num_blocks: int
            The number of blocks to use.
        - num_threads: int
            The number of threads per block.
        
        
        Returns:
        ------
        - file_path: str
        """
        if method == "1_point":
            self.generate_code(num_blocks, num_threads)
        else:
            self.generate_n_points_code(num_threads, poins_per_thread)
        file_path = self.write_code(file_path)
        return file_path
    

    