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
import sys
import os


from src.ultils.style import Style


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
                equations[var_name] = equation
        return equations

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

            if tokens[0] == ".inputs":
                inputs = tokens[1:]
                self.G.add_nodes_from(inputs, type="input")
            elif tokens[0] == ".outputs":
                outputs = tokens[1:]
                self.G.add_nodes_from(outputs, type="output")
            elif tokens[0] == ".names":
                parsing_names = True
                current_node = tokens[-1]
                dependencies = tokens[1:-1]
        
                node_data[current_node] = []
    
                input_order[current_node] = dependencies

                self.G.nodes[current_node]['input_order'] = dependencies
                self.G.nodes[current_node]['truth_value'] = None

                for dep in dependencies:
                    if dep not in self.G.nodes():
                        self.G.add_node(dep, type="intermediary", input_order=[], truth_value=None)
                    self.G.add_edge(dep, current_node)
            elif parsing_names and current_node is not None and len(tokens) > 1:
                input_values = tokens[:-1]
                output_value = tokens[-1]
                node_data[current_node].append({"input": input_values, "output": output_value})
        
        for node, partial_truth_table in node_data.items():
            num_vars = len(input_order[node])
            full_truth_table = self.__pla_to_binary_vector(partial_truth_table, num_vars)
            self.G.nodes[node]['truth_value'] = self.__binary_to_decimal("".join(map(str, full_truth_table)))
            if node in equations.keys():
                self.G.nodes[node]['equation'] = equations[node]
        
        if self.debug:
            import pprint 
            pprint.pprint(list(self.G.nodes(data=True)))

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

        # Count inputs and outputs
        self.inputs = [node for node, data in self.G.nodes(data=True) if data.get('type') == 'input']
        self.outputs = [node for node, data in self.G.nodes(data=True) if data.get('type') == 'output']
        self.num_inputs = len(self.inputs)
        self.num_outputs = len(self.outputs)
        
        # Get nodes in topological order
        self.ordered_nodes = list(nx.topological_sort(self.G))

        self.cuda_code = ""
    
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
        """
        Create the header for the CUDA code.

        Args:
        ------
        - None

        Returns:
        ------
        - None
        """
            
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
__global__ void evaluate_circuit(int *output) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int num_combinations = 1 << """ + str(self.num_inputs) + """;

    if (idx < num_combinations) {
        int x = idx;
        """
        # Initialize all variables to 0
        all_nodes = set(self.G.nodes())
        self.cuda_code += "\n        // Initialize all variables\n"
        for node in all_nodes:
            self.cuda_code += f"    unsigned int {node};\n"
        
        self.cuda_code += "\n        // Set input values\n"
        # Input variable assignments
        for i, input_var in enumerate(reversed(self.inputs)):
            self.cuda_code += f"        {input_var} = (x >> {i}) & 1;\n"
        
        self.cuda_code += "\n        // Evaluate circuit in topological order\n"
        
        # Generate equations in topological order
        for node in self.ordered_nodes:
            if node not in self.inputs:  # Skip input nodes
                input_order = self.G.nodes[node].get('input_order', [])
                truth_value = self.G.nodes[node].get('truth_value')
                
                if truth_value is not None and input_order:
                    shifts = []
                    for i, input_var in enumerate(input_order):
                        shifts.append(f"({input_var} << {len(input_order) - 1 - i})")
                    equation = f"        {node} = (({truth_value}U) >> (" + " + ".join(shifts) + ")) & 1;\n"
                    self.cuda_code += equation
        
        self.cuda_code += "\n        // Combine outputs into a single integer\n"
        self.cuda_code += "        output[idx] = 0;\n"
        
        # Combine outputs
        for i, output in enumerate(reversed(self.outputs)):
            self.cuda_code += f"        output[idx] |= ({output} << {i});\n"

        
        self.cuda_code += "    }\n}\n\n"

    def __generate_cuda_main(self) -> None:
        """
        Create the main function for the CUDA code.


        Args:
        ------
        - None

        Returns:
        ------
        - None

        """
        self.cuda_code += """
int main() {
    // Calculate number of input combinations
    const int num_inputs = """ + str(self.num_inputs) + """;
    const int num_combinations = 1 << num_inputs;
    const int output_size = num_combinations * sizeof(int);
    
    // Create CUDA events for timing
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    
    // Allocate host memory
    int *h_output = (int*)malloc(output_size);
    
    // Allocate device memory
    int *d_output;
    CHECK_CUDA_ERROR(cudaMalloc(&d_output, output_size));
    
    // Calculate grid and block dimensions
    int threadsPerBlock = 1024;
    // int blocksPerGrid = (num_combinations + threadsPerBlock - 1) / threadsPerBlock;
    int blocksPerGrid  = 1024*1024;
    
    // Record start time
    cudaEventRecord(start);
    
    // Launch kernel
    evaluate_circuit<<<blocksPerGrid, threadsPerBlock>>>(d_output);
    CHECK_CUDA_ERROR(cudaGetLastError());
    
    // Record stop time
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    
    // Calculate elapsed time
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);
    
    // Copy result back to host
    CHECK_CUDA_ERROR(cudaMemcpy(h_output, d_output, output_size, cudaMemcpyDeviceToHost));
    
    // Print timing information
    printf("\\nGPU Execution time: %.3f milliseconds\\n", milliseconds);
    
    // Print header only if we find invalid results
    bool header_printed = false;
    
    // Check results and print only invalid ones
    for (int i = 0; i < num_combinations; i++) {
        // Get input values
        int input1 = 0;
        int input2 = 0;
        
        // Extract first half of inputs for input1
        for (int j = num_inputs/2 - 1; j >= 0; j--) {
            input1 = (input1 << 1) | ((i >> (j + num_inputs/2)) & 1);
        }
        
        // Extract second half of inputs for input2
        for (int j = num_inputs/2 - 1; j >= 0; j--) {
            input2 = (input2 << 1) | ((i >> j) & 1);
        }
        
        // Calculate expected sum
        int expected_sum = input1 + input2;
        
        // Get actual output
        int actual_output = h_output[i];
        
        // Only print if the result is invalid
        if (actual_output != expected_sum) {
            // Print header if this is the first invalid result
            if (!header_printed) {
                printf("\\nInvalid Results:\\n");
                printf("Inputs");
                for (int k = 0; k < """ + str(self.num_inputs//3) + """; k++) {
                    printf("\\t");
                }
                printf("-> Output | Expected\\n");
                header_printed = true;
            }
            
            // Print input combinations
            for (int j = num_inputs - 1; j >= 0; j--) {
                printf("%d ", (i >> j) & 1);
            }
            printf("\\t-> ");
            
            // Print output values
            for (int j = """ + str(self.num_outputs - 1) + """; j >= 0; j--) {
                printf("%d", (actual_output >> j) & 1);
            }
            
            printf(" | Expected: %d, Got: %d\\n", expected_sum, actual_output);
        }
    }
    
    // Print message if no invalid results were found
    if (!header_printed) {
        printf("\\nAll results are valid!\\n");
    }
    
    // Cleanup
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    free(h_output);
    cudaFree(d_output);
    
    return 0;
}
"""

    #====================#
    # Public Methods     #
    #====================#

    def generate_code(self) -> str:
        """
        Generate the CUDA code for the LUT graph.

        Args:
        ------
        - None

        Returns:
        ------
        - cuda_code: str
            The generated CUDA code.
        """

        self.__generate_cuda_header()
        self.__generate_cuda_kernel()
        self.__generate_cuda_main()
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

    def run_code(self, executable:str) -> None:
        """
        Run the code.

        Args:
        ------
        - executable: str
            The name of the executable.
        
        Returns:
        ------
        - None
        """

        print(Style.BOLD + Style.OKGREEN + 
              f"Running CUDA code {executable}" + Style.ENDC)

        os.system(f"./{executable}")
        return None
    
    def run_with_profiling(self, executable:str) -> None:
        """
        Run the code with profiling.

        Args:
        ------
        - executable: str
            The name of the executable.

        Returns:
        ------
        - None

        Note:
        ------
        This method uses NVIDIA's Nsight Compute to profile the code.
        """

        print(Style.BOLD + Style.OKGREEN + 
              f"Running CUDA code {executable} with profile" + Style.ENDC)


        os.system(f"ncu ./{executable}")
        return None
    
    def run(self, file_path:str , profile:bool = False) -> None:
        """
        Run the CUDA code.

        Args:
        ------
        - file_path: str
            The path to the file.
        - profile: bool
            A flag that indicates if profiling should be used.
        
        
        Returns:
        ------
        - None
        """

        self.generate_code()
        file_path = self.write_code(file_path)
        executable = self.compile_code(file_path)
        self.run_code(executable) if not profile else self.run_with_profiling(executable)
        return None
    

    