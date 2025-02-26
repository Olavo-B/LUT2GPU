# /*****************************************************************************/
#  * File: cudaConstructor.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-01-27
#  * License: [License Type]
#  * Description: This script handle the code generation for CUDA code.
# /*****************************************************************************/


import networkx as nx
import os
import re


from ultils.style import Style, Mensage

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
    def __init__(self, graph:nx.DiGraph, max_inputs:int = 64, max_outputs:int = 64):
        self.mensage = Mensage()
        
        self.G = graph
        self.inputs = [node for node, data in self.G.nodes(data=True) if data.get('type') == 'input']
        self.outputs = [node for node, data in self.G.nodes(data=True) if data.get('type') == 'output']
        self.intermediary = [node for node, data in self.G.nodes(data=True) if data.get('type') == 'intermediary']
        self.num_inputs = len(self.inputs)
        self.num_outputs = len(self.outputs)

        self.ordered_nodes = list(nx.topological_sort(self.G))
        self.cuda_code = ""
        
        # Calculate effective number of inputs (limited to 64 bits)
        self.effective_inputs = min(self.num_inputs, max_inputs)
        # Calculate effective number of outputs (limited to 64 bits)
        self.effective_outputs = min(self.num_outputs, max_outputs)

        
        if self.num_inputs > max_inputs:
            self.mensage.warning(f"Number of inputs ({self.num_inputs}) exceeds {max_inputs} bits. Only using least significant {max_inputs} bits.")
        if self.num_outputs > max_outputs:
            self.mensage.warning(f"Number of outputs ({self.num_outputs}) exceeds {max_outputs} bits. Only storing least significant {max_outputs} bits.")
    
    def __str__(self):
        return self.cuda_code
    
    def __repr__(self):
        return self.cuda_code
    

    #====================#
    #  Private Methods   #
    #====================#
    
    def __generate_cuda_header(self) -> None:
        """Original header generation method with 64-bit types"""
        self.cuda_code = """
#include <stdio.h>
#include <cuda_runtime.h>
#include <stdlib.h>
#include <cstdlib> // For rand()
#include <random>
#include <vector>
#include <algorithm>


// Utility function to check CUDA errors
#define CHECK_CUDA_ERROR(call) { \\
    cudaError_t err = call; \\
    if (err != cudaSuccess) { \\
        printf("CUDA error: %s\\n", cudaGetErrorString(err)); \\
        exit(1); \\
    } \\
}
        """
        
    #===================================#
    # Generate CUDA code for processing #
    # N points per thread with 64-bit   #
    # limitation                        #
    #===================================#

    def __generate_variable_declarations(self) -> str:
        """Generate variable declarations using unsigned long long for large circuits"""
        code = "\n        // Initialize all variables\n"
        all_nodes = set(self.G.nodes())
        for node in all_nodes:
            # 2025-02-18 17:57:04: Change variable type to int
            code += f"    int {node} = 0;\n"
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

    def __generate_cuda_n_points_kernel(self, points_per_thread: int = 10000) -> None:
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

    def __generate_cuda_n_points_main(self, threads_per_block: int = 1024, points_per_thread: int = 10000) -> None:
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

    #===================================#
    # Generate CUDA code for processing #
    # one point per thread with 64-bit  #
    # limitation                        #
    #===================================#

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
            # 2025-02-18 17:57:04: Change variable type to int
            self.cuda_code += f"    int {node};\n"
        
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

    #===========================================================================#
    # 2025-02-18 17:28:17                                                       # 
    # Method to evaluate pruned circuits                                        # 
    # For more information, see the links:                                      #
    # https://excalidraw.com/#json=dD2sLsqfu7l5gRWRDknL1,ej7mqn44KJihcvw3KpoVgA #
    # https://excalidraw.com/#json=M1w6ra-W40Ku2GjYRafUr,3s59EjNpxx81gOY-lzxtDg #
    #===========================================================================#

    def __generate_cuda_auxiliary_functions_pruned(self) -> None:
        """
        Generate the auxiliary functions for pruned circuits. 
        It includes the following functions:
        - assert: 
            A function that checks if the input is equal to the expected value.
            It's uses hamming distance to calculate the difference between 
            the two values, but can be easily changed to another metric.
        - read_pruning_vectors:
            A function that reads the pruning vectors from a CSV file.

        """

        self.cuda_code += f"""
    __device__ bool alt_assert(unsigned long long input, unsigned long long expected) {{
        if (__popc(input ^ expected) != 0) {{
           return false;
        }}
        return true;
    }}

void generate_random_vector(int* h_input, int num_inputs, int num_combinations) {{
    // Use modern C++ random number generation
    std::random_device rd;
    std::mt19937_64 gen(rd());
    
    // Calculate the maximum value based on num_inputs
    unsigned long long max_val = (num_inputs >= 64) ? 
        (1ULL << 30) : (1ULL << num_inputs);
    
    // Pre-allocate vector instead of using a set
    std::vector<unsigned long long> numbers;
    numbers.reserve(num_combinations);
    
    if (num_combinations <= max_val / 4) {{  // If sparse sampling
        // Direct generation with uniform distribution
        std::uniform_int_distribution<unsigned long long> dis(0, max_val - 1);
        
        while (numbers.size() < num_combinations) {{
            unsigned long long val = dis(gen);
            if (std::find(numbers.begin(), numbers.end(), val) == numbers.end()) {{
                numbers.push_back(val);
            }}
        }}
    }} else {{  // If dense sampling
        // Generate sequential numbers and shuffle
        numbers.resize(max_val);
        std::iota(numbers.begin(), numbers.end(), 0ULL);
        std::shuffle(numbers.begin(), numbers.end(), gen);
        numbers.resize(num_combinations);
    }}
    
    // Copy to output array
    std::copy(numbers.begin(), numbers.end(), h_input);
}}

void read_pruning_vectors(const char* filename, int* h_p_vector, int totalThreads, int num_intermediary) {{
    FILE* file = fopen(filename, "r");
    if (!file) {{
        printf("Error: Could not open file %s\\n", filename);
        exit(1);
    }}

    char line[1024];
    int thread_idx = 0;
    
    // Skip header if exists
    fgets(line, sizeof(line), file);
    
    // Read data lines
    while (fgets(line, sizeof(line), file) && thread_idx < totalThreads) {{
        char* token = strtok(line, ",");
        int col = 0;
        
        while (token && col < num_intermediary) {{
            // Calculate the flat array index
            int flat_idx = thread_idx * num_intermediary + col;
            h_p_vector[flat_idx] = atoi(token);
            token = strtok(NULL, ",");
            col++;
        }}
        
        thread_idx++;
    }}
    
    if (thread_idx < totalThreads) {{
        printf("Warning: File contains fewer vectors (%d) than threads (%d)\\n", 
            thread_idx, totalThreads);
        
        // Copy last valid vector to remaining threads
        for (int i = thread_idx; i < totalThreads; i++) {{
            for (int j = 0; j < num_intermediary; j++) {{
                // Calculate flat indices for source and destination
                int dest_idx = i * num_intermediary + j;
                int src_idx = (thread_idx - 1) * num_intermediary + j;
                h_p_vector[dest_idx] = h_p_vector[src_idx];
            }}
        }}
    }}
    
    fclose(file);
}}
        """

    def __generate_cuda_kernel_pruned(self) -> None:
        """
        Generate the CUDA kernel for the pruned circuits.
        """

        self.cuda_code += f"""
    __global__ void evaluate_circuit(int *output, int *input, int inputsize, int *p_vector, int *v_vector) {{

        // Get the index of the thread
        unsigned long long idx = blockIdx.x * blockDim.x + threadIdx.x;
        int assert_count = 0; // sum of the assert function (max value is inputsize)
        const int num_intermediary = {len(self.intermediary)}; // Number of intermediary nodes

        // Pre-calculate p_vector and v_vector offsets for this thread
        const int p_offset = idx * num_intermediary;
        const int v_offset = idx * num_intermediary;
        """

        # Initialize all variables to 0
        all_nodes = set(self.G.nodes())
        self.cuda_code += "\n        // Initialize all variables\n"
        for node in all_nodes:
            # 2025-02-18 17:57:04: Change variable type to int
            self.cuda_code += f"    int {node};\n"

        self.cuda_code += f"""
        for (int i = 0; i < inputsize; i++) {{
        """



        # Input variable assignments
        self.cuda_code += "\n        // Set input values\n"
        self.cuda_code += "        unsigned long long x = input[i];\n"

        for i, input_var in enumerate(reversed(self.inputs)):
            self.cuda_code += f"        {input_var} = (x >> {i}) & 1;\n"

        self.cuda_code += "\n        // Evaluate circuit in topological order\n"

        # Generate equations in topological order
        for node in self.ordered_nodes:
            if node not in self.inputs:
                equation = self.G.nodes[node].get('equation')
                if equation is not None:
                    self.cuda_code += f"        {node} = ({equation});\n"

        self.cuda_code += "\n        // Combine outputs into a single integer\n"
        # Adjust output indexing to use relative index within the launch
        self.cuda_code += "        unsigned long long expected_output_word = 0;\n"

        # Combine outputs
        for i, output in enumerate(self.outputs):
            self.cuda_code += f"        expected_output_word |= ({output} << {i});\n"

        # 2025-02-19 17:50:15: Input variable assignments again due to new evaluation

        for i, input_var in enumerate(reversed(self.inputs)):
            self.cuda_code += f"        {input_var} = (x >> {i}) & 1;\n"

        # Generate equations in topological order and make intermediary node 
        # a probabilistic assignment
        self.cuda_code += "\n        // Evaluate circuit in topological order\n"
        j = 0
        for node in self.ordered_nodes:
            if node not in self.inputs:
                equation = self.G.nodes[node].get('equation')
                if node in self.intermediary:
                    # If the node is an intermediary node, assign a probabilistic value to it
                    self.cuda_code += f"        {node} = p_vector[p_offset + {j}] ? v_vector[v_offset + {j}] : ({equation});\n"
                    j += 1
                elif equation is not None:
                    # If the node is not an intermediary node (it is a output then), assign the value of the equation
                    self.cuda_code += f"        {node} = ({equation});\n"
        
        self.cuda_code += "\n        // Combine outputs into a single integer\n"
        # Adjust output indexing to use relative index within the launch
        self.cuda_code += "        unsigned long long pruned_output_word = 0;\n"

        # Combine outputs
        for i, output in enumerate(self.outputs):
            self.cuda_code += f"        pruned_output_word |= ({output} << {i});\n"

        self.cuda_code += """
        // Check if the output is the expected output
        assert_count += alt_assert(pruned_output_word, expected_output_word);
        }
        """

        self.cuda_code += "output[idx] = assert_count;\n"

        self.cuda_code += """

    }

        """

    def __generate_cuda_main_pruned(self, threads_per_block:int = 256, 
                                    p_vector_path:str = "pruning_vectors.csv", 
                                    file_path:str = '.') -> None:
        
        # Get the path removing the file name
        file_path = os.path.dirname(file_path)

        self.cuda_code += f"""
        

        int main() {{
            // Circuit parameters
            const unsigned long long num_inputs = {self.num_inputs};
            const int num_used_inputs = 21;
            const int num_intermediary = {len(self.intermediary)};
            const int num_combinations = 1 << num_used_inputs;
            
            // CUDA parameters
            const int threadsPerBlock = {threads_per_block};
            const int numSMs = 24;  // For RTX 4060
            const int blocksPerSM = 32;
            const int optimalBlocks = numSMs * blocksPerSM;  // 768 blocks
            const int totalThreads = optimalBlocks * threadsPerBlock;
            
            printf("Circuit Configuration:\\n");
            printf("Number of inputs: %llu\\n", num_inputs);
            printf("Number of effective inputs: %d\\n", num_used_inputs);
            printf("Number of intermediary nodes: %d\\n", num_intermediary);
            printf("Number of input combinations: %d\\n", num_combinations);
            printf("\\nCUDA Configuration:\\n");
            printf("Threads per block: %d\\n", threadsPerBlock);
            printf("Number of blocks: %d\\n", optimalBlocks);
            printf("Total threads: %d\\n\\n", totalThreads);
            
            // Timing events
            cudaEvent_t start, stop;
            CHECK_CUDA_ERROR(cudaEventCreate(&start));
            CHECK_CUDA_ERROR(cudaEventCreate(&stop));
            
            // Allocate host memory
            int *h_input = (int*)malloc(num_combinations * sizeof(int));
            int *h_output = (int*)malloc(totalThreads * sizeof(int));
            int *h_p_vector = (int*)malloc(totalThreads * num_intermediary * sizeof(int));
            int *h_v_vector = (int*)malloc(totalThreads * num_intermediary * sizeof(int));
            
            if (!h_input || !h_output || !h_p_vector || !h_v_vector) {{
                printf("Error: Host memory allocation failed\\n");
                exit(1);
            }}
            
            // Initialize input combinations
            /*
            *for (int i = 0; i < num_combinations; i++) {{
            *    h_input[i] = (unsigned long long)i;
            *}}
            */
            generate_random_vector(h_input, num_used_inputs, num_combinations);
            
            // Allocate and initialize vectors for each thread
            for (int i = 0; i < totalThreads; i++) {{
                // Initialize v_vector with random values 0 or 1
                for (int j = 0; j < num_intermediary; j++) {{
                    h_v_vector[i * num_intermediary + j] = (rand() % 2);
                }}
            }}
            
            // Read pruning vectors from CSV
            read_pruning_vectors("{p_vector_path}", h_p_vector, totalThreads, num_intermediary);
            
            // Allocate device memory
            int *d_input, *d_output;
            int *d_p_vector, *d_v_vector;
            CHECK_CUDA_ERROR(cudaMalloc(&d_input, num_combinations * sizeof(int)));
            CHECK_CUDA_ERROR(cudaMalloc(&d_output, totalThreads * sizeof(int)));
            CHECK_CUDA_ERROR(cudaMalloc(&d_p_vector, totalThreads * num_intermediary * sizeof(int)));
            CHECK_CUDA_ERROR(cudaMalloc(&d_v_vector, totalThreads * num_intermediary * sizeof(int)));
            
            // Copy data to device
            CHECK_CUDA_ERROR(cudaMemcpy(d_input, h_input, num_combinations * sizeof(int), cudaMemcpyHostToDevice));
            CHECK_CUDA_ERROR(cudaMemcpy(d_p_vector, h_p_vector, totalThreads * num_intermediary * sizeof(int), cudaMemcpyHostToDevice));
            CHECK_CUDA_ERROR(cudaMemcpy(d_v_vector, h_v_vector, totalThreads * num_intermediary * sizeof(int), cudaMemcpyHostToDevice));


            
            
            
            // Launch kernel
            printf("Starting kernel execution...\\n");
            CHECK_CUDA_ERROR(cudaEventRecord(start));
            evaluate_circuit<<<optimalBlocks, threadsPerBlock>>>(d_output, d_input, num_combinations, d_p_vector, d_v_vector);
            CHECK_CUDA_ERROR(cudaEventRecord(stop));
            
            // Copy results back to host
            CHECK_CUDA_ERROR(cudaMemcpy(h_output, d_output, totalThreads * sizeof(int), cudaMemcpyDeviceToHost));
            
            // Calculate elapsed time
            CHECK_CUDA_ERROR(cudaEventSynchronize(stop));
            float milliseconds = 0;
            CHECK_CUDA_ERROR(cudaEventElapsedTime(&milliseconds, start, stop));
            printf("GPU Execution time: %.3f milliseconds\\n", milliseconds);
        
            
            // Find best result
            int best_thread = 0;
            int best_match_count = h_output[0];
            for (int i = 1; i < totalThreads; i++) {{
                if (h_output[i] > best_match_count) {{
                    best_match_count = h_output[i];
                    best_thread = i;
                }}
            }}
            
            // Print results
            printf("\\nResults:\\n");
            printf("Execution time: %.3f ms\\n", milliseconds);
            printf("Best thread: %d\\n", best_thread);
            printf("Match count: %d/%d\\n", best_match_count, num_combinations);
            printf("Match percentage: %.2f%%\\n", (float)best_match_count / num_combinations * 100);

            // Save all results
            printf("\\nSaving results...\\n");
            FILE* results = fopen("{file_path}/results.csv", "w");
            if (results) {{
                fprintf(results, "thread_index,match_count\\n");
                for (int i = 0; i < totalThreads; i++) {{
                    fprintf(results, "%d,%d\\n", i, h_output[i]);
                }}
                fclose(results);
                printf("Results saved to 'results.csv'\\n");
            }}
            
            // Save best configuration
            printf("\\nSaving best configuration...\\n");
            FILE* best_config = fopen("{file_path}/best_config.csv", "w");
            if (best_config) {{
                fprintf(best_config, "node_index,p_value,v_value\\n");
                for (int j = 0; j < num_intermediary; j++) {{
                    fprintf(best_config, "%d,%d,%d\\n", j, h_p_vector[best_thread * num_intermediary + j], h_v_vector[best_thread * num_intermediary + j]);
                }}
                fclose(best_config);
                printf("Best configuration saved to 'best_config.csv'\\n");
            }}
            
            // Cleanup
            free(h_input);
            free(h_output);
            free(h_p_vector);
            free(h_v_vector);
            
            CHECK_CUDA_ERROR(cudaFree(d_input));
            CHECK_CUDA_ERROR(cudaFree(d_output));
            CHECK_CUDA_ERROR(cudaFree(d_p_vector));
            CHECK_CUDA_ERROR(cudaFree(d_v_vector));
            
            CHECK_CUDA_ERROR(cudaEventDestroy(start));
            CHECK_CUDA_ERROR(cudaEventDestroy(stop));
            
            return 0;
        }}
        """


    #====================#
    # Public Methods     #
    #====================#

    def generate_pruned_code(self, threads_per_block:int = 256, 
                             p_vector_path:str = "pruning_vectors.csv",
                             file_path:str = '.') -> str:
        """
        Generate the CUDA code for the pruned circuits.

        Args:
        ------
        - threads_per_block: int
            The number of threads per block.
        
        Returns:
        ------
        - cuda_code: str
            The generated CUDA code.
        """

        self.__generate_cuda_header()
        self.__generate_cuda_auxiliary_functions_pruned()
        self.__generate_cuda_kernel_pruned()
        self.__generate_cuda_main_pruned(threads_per_block, p_vector_path, file_path)
        return self.cuda_code

    def generate_n_points_code(self, threads_per_block: int = 1024, points_per_thread: int = 10000) -> str:
        """Generate CUDA code with N points per thread support and 64-bit limitation
        
        Args:
        ------
        - threads_per_block: int
            The number of threads per block.
        - points_per_thread: int
            The number of points to process per thread.
        
        Returns:
        ------
        - cuda_code: str
            The generated CUDA code.

        """
        self.__generate_cuda_header()
        self.__generate_cuda_n_points_kernel(points_per_thread)
        self.__generate_cuda_n_points_main(threads_per_block, points_per_thread)
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

    def run(self, file_path:str ,
            method:str = "1_point", 
            num_blocks:int = 1024, 
            num_threads:int = 1024, 
            poins_per_thread:int = 10000,
            p_vector_path:str = "pruning_vectors.csv") -> str:
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
        elif method == "n_points":
            self.generate_n_points_code(num_threads, poins_per_thread)
        elif method == "pruned":
            self.generate_pruned_code(num_threads, p_vector_path, file_path)

        file_path = self.write_code(file_path)
        self.mensage.success(f"CUDA code generatrion complete, code saved to {file_path}")
        return file_path
    

    