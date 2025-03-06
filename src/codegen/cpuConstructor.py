# /*****************************************************************************/
#  * File: cpuConstructor.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-02-26
#  * License: [License Type]
#  * Description: This script handles the code generation for C++ CPU code with OpenMP.
# /*****************************************************************************/


import networkx as nx
import os
import re

from ultils.style import Style, Mensage

class CppGenerator():
    """
    Class that generates C++ CPU code with OpenMP for a LUT graph.

    Attributes:
    - G: nx.DiGraph
        A directed graph representing the LUT.
    - inputs: list
        A list of input nodes.
    - outputs: list
        A list of output nodes.
    - intermediary: list
        A list of intermediary nodes.
    - num_inputs: int
        The number of input nodes.
    - num_outputs: int
        The number of output nodes.
    - ordered_nodes: list
        A list of nodes in topological order.
    - cpp_code: str
        The generated C++ code.
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
        self.cpp_code = ""
        
        # Calculate effective number of inputs (limited to 64 bits)
        self.effective_inputs = min(self.num_inputs, max_inputs)
        # Calculate effective number of outputs (limited to 64 bits)
        self.effective_outputs = min(self.num_outputs, max_outputs)

        
        if self.num_inputs > max_inputs:
            self.mensage.warning(f"Number of inputs ({self.num_inputs}) exceeds {max_inputs} bits. Only using least significant {max_inputs} bits.")
        if self.num_outputs > max_outputs:
            self.mensage.warning(f"Number of outputs ({self.num_outputs}) exceeds {max_outputs} bits. Only storing least significant {max_outputs} bits.")

    
    def __str__(self):
        return self.cpp_code
    
    def __repr__(self):
        return self.cpp_code
    

    #====================#
    #  Private Methods   #
    #====================#
    
    def __generate_cpp_header(self) -> None:
        """Generate C++ header with OpenMP includes and common utilities"""
        self.cpp_code = """
#include <iostream>
#include <vector>
#include <chrono>
#include <cstdint>
#include <cmath>
#include <fstream>
#include <algorithm>
#include <random>
#include <omp.h>

// Utility function for timing
class Timer {
private:
    std::chrono::high_resolution_clock::time_point start_time;
    std::string operation_name;

public:
    Timer(const std::string& name) : operation_name(name) {
        start_time = std::chrono::high_resolution_clock::now();
    }

    ~Timer() {
        auto end_time = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time).count();
        std::cout << operation_name << " execution time: " << duration << " milliseconds" << std::endl;
    }
};
        """

    def __generate_auxiliary_functions(self) -> None:
        """
        Generate the auxiliary functions for the CUDA code.
        In this case, it includes:

        - save_results:
            A function that saves the results to a CSV file.
        - read_input_combinations:
            A function that reads the input combinations from a CSV file.
        """
                
        self.cpp_code += """
// Function that saves the results to a CSV file
void save_results(const std::string& filename, const std::vector<uint64_t>& results) {
    std::ofstream

    outfile(filename);

    if (outfile.is_open()) {
        outfile << "thread_index,match_count\\n";
        for (int i = 0; i < results.size(); i++) {
            outfile << i << "," << results[i] << std::endl;
        }
        outfile.close();
    }
}

// Function that reads input combinations from a CSV file
void read_input_combinations(const std::string& filename, std::vector<std::vector<uint64_t>>& input_combinations) {
    std::ifstream

    file(filename);

    if (!file.is_open()) {
        std::cerr << "Error: Could not open file " << filename << std::endl;
        exit(1);
    }

    std::string line;
    while (std::getline(file, line)) {
        uint64_t x = std::stoull(line);
        input_combinations.push_back({x});
    }

    file.close();

    std::cout << "Read " << input_combinations.size() << " input combinations from " << filename << std::endl;

}
    """
  
    #===================================#
    # Generate C++ code for processing  #
    # N points per thread using OpenMP  #
    #===================================#

    def __generate_variable_declarations(self) -> str:
        """Generate variable declarations for all circuit nodes"""
        code = "\n        // Initialize all variables\n"
        all_nodes = set(self.G.nodes())
        for node in all_nodes:
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
                    # Convert CUDA/C operators to C++ equivalents if needed
                    cpp_equation = equation.replace("&&", "&&").replace("||", "||").replace("!", "!")
                    code += f"        {node} = ({cpp_equation});\n"
        return code

    def __generate_output_assignments(self) -> str:
        """Generate output assignments limited to 64 bits"""
        code = "\n        // Store result for this point\n"
        code += "        result = 0;\n"
        for i, output in enumerate(self.outputs[:self.effective_outputs]):
            code += f"        result |= ((uint64_t){output} & 1ULL) << {i};\n"
        return code

    def __generate_cpp_n_points_function(self, chunk_size: int = 10000) -> None:
        """Generate C++ function for processing N points in parallel with OpenMP"""
        self.cpp_code += f"""
void evaluate_circuit(std::vector<uint64_t>& output, uint64_t start_idx, uint64_t end_idx, int chunk_size) {{
    // Calculate the number of points to process
    uint64_t num_points = end_idx - start_idx;
    
    // Resize output vector if needed
    if (output.size() < num_points) {{
        output.resize(num_points);
    }}
    
    // Use OpenMP to parallelize computation
    #pragma omp parallel
    {{
        {self.__generate_variable_declarations()}
        uint64_t result = 0;
        
        // Process chunks of points in parallel
        #pragma omp for schedule(dynamic, chunk_size)
        for (uint64_t i = 0; i < num_points; i++) {{
            uint64_t idx = start_idx + i;
            uint64_t x = idx;
            
            {self.__generate_input_assignments()}
            {self.__generate_circuit_evaluation()}
            {self.__generate_output_assignments()}
            
            // Store the result
            output[i] = result;
        }}
    }}
}}
    """

    def __generate_cpp_n_points_main(self, chunk_size: int = 10000, file_path: str = '.') -> None:
        """Generate main function with OpenMP parallel processing"""

        # Get the path removing the file name
        file_path = os.path.dirname(file_path)

        self.cpp_code += f"""
int main(int argc, char* argv[]) {{
    const uint64_t num_inputs = {self.effective_inputs};  // Limited to 64 bits
    const uint64_t num_combinations = 1ULL << num_inputs;
    
    // Determine number of threads and chunk size
    int num_threads = omp_get_max_threads();
    int chunk_size = {chunk_size};
    
    // Process command line arguments if provided
    if (argc > 1) {{
        num_threads = std::stoi(argv[1]);
        omp_set_num_threads(num_threads);
    }}
    if (argc > 2) {{
        chunk_size = std::stoi(argv[2]);
    }}
    
    std::cout << "Circuit Evaluation on CPU with OpenMP" << std::endl;
    std::cout << "Using " << num_inputs << " least significant input bits" << std::endl;
    std::cout << "Using " << {self.effective_outputs} << " least significant output bits" << std::endl;
    std::cout << "Number of threads: " << num_threads << std::endl;
    std::cout << "Chunk size: " << chunk_size << std::endl;
    std::cout << "Total combinations to evaluate: " << num_combinations << std::endl;
    
    // Set a reasonable batch size based on memory limits
    const uint64_t max_batch_size = 100000000; // 100 million
    const uint64_t batch_size = std::min(num_combinations, max_batch_size);
    const uint64_t num_batches = (num_combinations + batch_size - 1) / batch_size;

    std::cout << "Num batches: " << num_batches << std::endl;

    // Allocate output vector
    std::vector<uint64_t> output(batch_size);
    std::vector<uint64_t> results;
    
    // Start timer
    Timer timer("Total circuit evaluation");
    
    // Process all combinations in batches
    for (uint64_t batch = 0; batch < num_batches; batch++) {{
        uint64_t start_idx = batch * batch_size;
        uint64_t end_idx = std::min(start_idx + batch_size, num_combinations);
        
        
        // Evaluate circuit for this batch
        Timer batch_timer("Batch processing");
        evaluate_circuit(output, start_idx, end_idx, chunk_size);
        
        // Option to save results to file if needed
        // To enable, uncomment the following code:
        results.insert(results.begin() + start_idx, output.begin(), output.end());
    }}

    // Save results to file if needed
    // To enable, uncomment the following code:
    save_results("{file_path}/output.csv", results);
    
    return 0;
}}
    """

    #===================================#
    # Generate C++ code for processing  #
    # one point per thread with OpenMP  #
    #===================================#

    def __generate_cpp_standard_function(self) -> None:
        """Create the C++ function for the LUT evaluation with OpenMP"""
        self.cpp_code += """
void evaluate_circuit(std::vector<int>& output, uint64_t start_idx, uint64_t end_idx) {
    const uint64_t num_points = end_idx - start_idx;
    
    // Resize output vector if needed
    if (output.size() < num_points) {
        output.resize(num_points);
    }
    
    #pragma omp parallel for schedule(dynamic, 1024)
    for (uint64_t i = 0; i < num_points; i++) {
        uint64_t idx = start_idx + i;
        uint64_t x = idx;
        """
        # Initialize all variables to 0
        all_nodes = set(self.G.nodes())
        self.cpp_code += "\n        // Initialize all variables\n"
        for node in all_nodes:
            self.cpp_code += f"        int {node} = 0;\n"
        
        self.cpp_code += "\n        // Set input values\n"
        # Input variable assignments
        for i, input_var in enumerate(reversed(self.inputs)):
            self.cpp_code += f"        {input_var} = (x >> {i}) & 1;\n"
        
        self.cpp_code += "\n        // Evaluate circuit in topological order\n"
        
        # Generate equations in topological order
        for node in self.ordered_nodes:
            if node not in self.inputs:  # Skip input nodes
                equation = self.G.nodes[node].get('equation')
                if equation is not None:
                    # Convert any CUDA-specific syntax to C++ if needed
                    cpp_equation = equation.replace("&&", "&&").replace("||", "||").replace("!", "!")
                    self.cpp_code += f"        {node} = ({cpp_equation});\n"
        
        self.cpp_code += "\n        // Combine outputs into a single integer\n"
        # Initialize output to 0
        self.cpp_code += "        output[i] = 0;\n"
        
        # Combine outputs
        for i, output in enumerate(self.outputs):
            self.cpp_code += f"        output[i] |= ({output} << {i});\n"
        
        self.cpp_code += "    }\n}\n\n"

    def __generate_cpp_main(self, file_path:str = '.') -> None:
        """Create the main function with improved memory management and OpenMP parallelism"""

        file_path = os.path.dirname(file_path)

        self.cpp_code += f"""
int main(int argc, char* argv[]) {{
    // Calculate number of input combinations
    const uint64_t num_inputs = {self.num_inputs};
    const uint64_t num_combinations = 1ULL << num_inputs;
    
    // Get the number of available threads
    int num_threads = omp_get_max_threads();
    if (argc > 1) {{
        num_threads = std::stoi(argv[1]);
        omp_set_num_threads(num_threads);
    }}
    
    std::cout << "Circuit Evaluation on CPU with OpenMP" << std::endl;
    std::cout << "Number of inputs: " << num_inputs << std::endl;
    std::cout << "Number of outputs: " << {self.num_outputs} << std::endl;
    std::cout << "Number of threads: " << num_threads << std::endl;
    std::cout << "Total combinations to evaluate: " << num_combinations << std::endl;
    
    // Set a reasonable batch size based on memory limits
    const uint64_t max_batch_size = 100000000; // 100 million
    const uint64_t batch_size = std::min(num_combinations, max_batch_size);
    const uint64_t num_batches = (num_combinations + batch_size - 1) / batch_size;
    

    
    // Allocate output vector
    std::vector<int> output(batch_size);
    std::vector<int> results;
    
    // Start timer
    Timer timer("Total circuit evaluation");
    
    // Process all combinations in batches
    for (uint64_t batch = 0; batch < num_batches; batch++) {{
        uint64_t start_idx = batch * batch_size;
        uint64_t end_idx = std::min(start_idx + batch_size, num_combinations);
        

        // Evaluate circuit for this batch
        Timer batch_timer("Batch processing");
        evaluate_circuit(output, start_idx, end_idx);
        
        // Option to save results to file if needed
        // To enable, uncomment the following code:
        results.insert(results.end(), output.begin(), output.end());
    }}

    // Save results to file if needed
    // To enable, uncomment the following code:
    // save_results("{file_path}/output.csv", results);
    
    return 0;
}}
    """

    #===========================================================================#
    # Method to evaluate pruned circuits                                        # 
    # Convert the CUDA implementation to OpenMP for CPU                         #
    #===========================================================================#

    def __generate_cpp_auxiliary_functions_pruned(self) -> None:
        """Generate the auxiliary functions for pruned circuits on CPU"""
        self.cpp_code += f"""
// Function to count bits that differ between two values (Hamming distance)
int hamming_distance(uint64_t a, uint64_t b) {{
    return __builtin_popcountll(a ^ b);
}}

// Alternative assert function using Hamming distance
bool alt_assert(uint64_t input, uint64_t expected) {{
    if (hamming_distance(input, expected) != 0) {{
        return false;
    }}
    return true;
}}

// Generate random input vectors
void generate_random_vector(std::vector<int>& h_input, int num_inputs, int num_combinations) {{
    // Use modern C++ random number generation
    std::random_device rd;
    std::mt19937_64 gen(rd());
    
    // Calculate the maximum value based on num_inputs
    uint64_t max_val = (num_inputs >= 64) ? 
        (1ULL << 30) : (1ULL << num_inputs);
    
    // Pre-allocate vector
    std::vector<uint64_t> numbers;
    numbers.reserve(num_combinations);
    
    if (num_combinations <= max_val / 4) {{  // If sparse sampling
        // Direct generation with uniform distribution
        std::uniform_int_distribution<uint64_t> dis(0, max_val - 1);
        
        while (numbers.size() < num_combinations) {{
            uint64_t val = dis(gen);
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
    h_input.resize(num_combinations);
    for (int i = 0; i < num_combinations; i++) {{
        h_input[i] = numbers[i];
    }}
}}

// Read pruning vectors from CSV file
void read_pruning_vectors(const std::string& filename, std::vector<int>& p_vector, 
                        int total_threads, int num_intermediary) {{
    std::ifstream file(filename);
    if (!file.is_open()) {{
        std::cerr << "Error: Could not open file " << filename << std::endl;
        exit(1);
    }}

    std::string line;
    int thread_idx = 0;
    
    // Skip header if exists
    std::getline(file, line);
    
    // Read data lines
    while (std::getline(file, line) && thread_idx < total_threads) {{
        std::istringstream line_stream(line);
        std::string token;
        int col = 0;
        
        while (std::getline(line_stream, token, ',') && col < num_intermediary) {{
            // Calculate the flat array index
            int flat_idx = thread_idx * num_intermediary + col;
            p_vector[flat_idx] = std::stoi(token);
            col++;
        }}
        
        thread_idx++;
    }}
    
    if (thread_idx < total_threads) {{
        std::cout << "Warning: File contains fewer vectors (" << thread_idx << ") than threads (" 
                << total_threads << ")" << std::endl;
        
        // Copy last valid vector to remaining threads
        for (int i = thread_idx; i < total_threads; i++) {{
            for (int j = 0; j < num_intermediary; j++) {{
                // Calculate flat indices for source and destination
                int dest_idx = i * num_intermediary + j;
                int src_idx = (thread_idx - 1) * num_intermediary + j;
                p_vector[dest_idx] = p_vector[src_idx];
            }}
        }}
    }}
    
    file.close();
}}
        """

    def __generate_cpp_pruned_function(self) -> None:
        """Generate the OpenMP function for the pruned circuits"""
        self.cpp_code += f"""
void evaluate_circuit_pruned(const std::vector<int>& input, int inputsize,
                          const std::vector<int>& p_vector, const std::vector<int>& v_vector,
                          std::vector<int>& output, int total_threads) {{
    
    const int num_intermediary = {len(self.intermediary)}; // Number of intermediary nodes
    
    // Make sure output vector is properly sized
    if (output.size() < total_threads) {{
        output.resize(total_threads);
    }}
    
    // Parallelize over threads
    #pragma omp parallel for schedule(dynamic)
    for (int idx = 0; idx < total_threads; idx++) {{
        int assert_count = 0; // sum of the assert function (max value is inputsize)
        
        // Pre-calculate p_vector and v_vector offsets for this thread
        const int p_offset = idx * num_intermediary;
        const int v_offset = idx * num_intermediary;
        """

        # Initialize all variables
        all_nodes = set(self.G.nodes())
        self.cpp_code += "\n        // Declare all circuit variables\n"
        for node in all_nodes:
            self.cpp_code += f"        int {node};\n"

        self.cpp_code += f"""
        // Process each input combination
        for (int i = 0; i < inputsize; i++) {{
            // First pass: evaluate original circuit
            unsigned long long x = input[i];
        """

        # Input variable assignments
        self.cpp_code += "\n            // Set input values\n"
        for i, input_var in enumerate(reversed(self.inputs)):
            self.cpp_code += f"            {input_var} = (x >> {i}) & 1;\n"

        self.cpp_code += "\n            // Evaluate original circuit in topological order\n"
        # Generate equations in topological order
        for node in self.ordered_nodes:
            if node not in self.inputs:
                equation = self.G.nodes[node].get('equation')
                if equation is not None:
                    # Convert any CUDA-specific syntax to C++ if needed
                    cpp_equation = equation.replace("&&", "&&").replace("||", "||").replace("!", "!")
                    self.cpp_code += f"            {node} = ({cpp_equation});\n"

        self.cpp_code += "\n            // Combine outputs into a single integer\n"
        self.cpp_code += "            uint64_t expected_output_word = 0;\n"
        # Combine outputs
        for i, output in enumerate(self.outputs):
            self.cpp_code += f"            expected_output_word |= (static_cast<uint64_t>({output}) << {i});\n"

        # Second pass: evaluate pruned circuit
        self.cpp_code += "\n            // Second pass: evaluate pruned circuit\n"
        
        # Input variable assignments again
        for i, input_var in enumerate(reversed(self.inputs)):
            self.cpp_code += f"            {input_var} = (x >> {i}) & 1;\n"

        # Generate equations for pruned circuit
        self.cpp_code += "\n            // Evaluate pruned circuit in topological order\n"
        j = 0
        for node in self.ordered_nodes:
            if node not in self.inputs:
                equation = self.G.nodes[node].get('equation')
                if node in self.intermediary:
                    # If node is intermediary, use pruning vector
                    cpp_equation = equation.replace("&&", "&&").replace("||", "||").replace("!", "!")
                    self.cpp_code += f"            {node} = p_vector[p_offset + {j}] ? v_vector[v_offset + {j}] : ({cpp_equation});\n"
                    j += 1
                elif equation is not None:
                    # For output nodes
                    cpp_equation = equation.replace("&&", "&&").replace("||", "||").replace("!", "!")
                    self.cpp_code += f"            {node} = ({cpp_equation});\n"

        self.cpp_code += "\n            // Combine pruned outputs into a single integer\n"
        self.cpp_code += "            uint64_t pruned_output_word = 0;\n"
        # Combine outputs
        for i, output in enumerate(self.outputs):
            self.cpp_code += f"            pruned_output_word |= (static_cast<uint64_t>({output}) << {i});\n"

        self.cpp_code += """
            // Check if pruned output matches expected output
            assert_count += alt_assert(pruned_output_word, expected_output_word);
        }
        
        // Store result for this thread
        output[idx] = assert_count;
    }
}
        """

    def __generate_cpp_main_pruned(self, p_vector_path:str = "pruning_vectors.csv", 
                                file_path:str = '.') -> None:
        # Get the path removing the file name
        file_path = os.path.dirname(file_path)
        
        self.cpp_code += f"""
int main(int argc, char* argv[]) {{
    // Circuit parameters
    const uint64_t num_inputs = {self.num_inputs};
    const int num_used_inputs = 21;
    const int num_intermediary = {len(self.intermediary)};
    const int num_combinations = 1 << num_used_inputs;
    
    // Threading parameters
    int num_threads = omp_get_max_threads();
    if (argc > 1) {{
        num_threads = std::stoi(argv[1]);
        omp_set_num_threads(num_threads);
    }}
    
    // Calculate total threads to match CUDA configuration
    const int threadsPerBlock = 256;
    const int optimalBlocks = 768;  // 24 SMs * 32 blocks per SM for equivalence with CUDA
    const int total_threads = optimalBlocks * threadsPerBlock;
    
    std::cout << "Circuit Configuration:" << std::endl;
    std::cout << "Number of inputs: " << num_inputs << std::endl;
    std::cout << "Number of effective inputs: " << num_used_inputs << std::endl;
    std::cout << "Number of intermediary nodes: " << num_intermediary << std::endl;
    std::cout << "Number of input combinations: " << num_combinations << std::endl;
    std::cout << std::endl << "OpenMP Configuration:" << std::endl;
    std::cout << "Number of physical threads: " << num_threads << std::endl;
    std::cout << "Total virtual threads: " << total_threads << std::endl;
    
    // Allocate host memory
    std::vector<int> input(num_combinations);
    std::vector<int> output(total_threads);
    std::vector<int> p_vector(total_threads * num_intermediary);
    std::vector<int> v_vector(total_threads * num_intermediary);
    
    // Initialize input combinations
    generate_random_vector(input, num_used_inputs, num_combinations);
    
    // Initialize v_vector with random values 0 or 1
    for (int i = 0; i < total_threads; i++) {{
        for (int j = 0; j < num_intermediary; j++) {{
            v_vector[i * num_intermediary + j] = (rand() % 2);
        }}
    }}
    
    // Read pruning vectors from CSV
    read_pruning_vectors("{p_vector_path}", p_vector, total_threads, num_intermediary);
    
    // Launch evaluation
    std::cout << "Starting circuit evaluation..." << std::endl;
    
    // Create timer
    Timer timer("Circuit evaluation");
    
    // Evaluate circuit
    evaluate_circuit_pruned(input, num_combinations, p_vector, v_vector, output, total_threads);
    
    // Find best result
    int best_thread = 0;
    int best_match_count = output[0];
    for (int i = 1; i < total_threads; i++) {{
        if (output[i] > best_match_count) {{
            best_match_count = output[i];
            best_thread = i;
        }}
    }}
    
    // Print results
    std::cout << std::endl << "Results:" << std::endl;
    std::cout << "Best thread: " << best_thread << std::endl;
    std::cout << "Match count: " << best_match_count << "/" << num_combinations << std::endl;
    std::cout << "Match percentage: " << (static_cast<float>(best_match_count) / num_combinations * 100) << "%" << std::endl;
    
    // Save all results
    std::cout << std::endl << "Saving results..." << std::endl;
    save_results("{file_path}/output.csv", output);
    std::ofstream results_file("{file_path}/results.csv");
    if (results_file.is_open()) {{
        results_file << "thread_index,match_count" << std::endl;
        for (int i = 0; i < total_threads; i++) {{
            results_file << i << "," << output[i] << std::endl;
        }}
        results_file.close();
        std::cout << "Results saved to 'results.csv'" << std::endl;
    }}
    
    // Save best configuration
    std::cout << std::endl << "Saving best configuration..." << std::endl;
    std::ofstream best_config_file("{file_path}/best_config.csv");
    if (best_config_file.is_open()) {{
        best_config_file << "node_index,p_value,v_value" << std::endl;
        for (int j = 0; j < num_intermediary; j++) {{
            best_config_file << j << "," 
                           << p_vector[best_thread * num_intermediary + j] << "," 
                           << v_vector[best_thread * num_intermediary + j] << std::endl;
        }}
        best_config_file.close();
        std::cout << "Best configuration saved to 'best_config.csv'" << std::endl;
    }}
    
    return 0;
}}
        """

    #====================#
    # Public Methods     #
    #====================#

    def generate_pruned_code(self, p_vector_path:str = "pruning_vectors.csv",
                          file_path:str = '.') -> str:
        """
        Generate the C++ OpenMP code for the pruned circuits.

        Args:
        ------
        - p_vector_path: str
            Path to the pruning vectors CSV file.
        - file_path: str
            Path to save the output files.
        
        Returns:
        --------
        - str
            The generated C++ code.
        """
        self.__generate_cpp_header()
        self.__generate_cpp_auxiliary_functions_pruned()
        self.__generate_cpp_pruned_function()
        self.__generate_cpp_main_pruned(p_vector_path, file_path)
        return self.cpp_code
    
    def generate_code(self, chunk_size: int = 10000, file_path:str = '.') -> str:
        """
        Generate the C++ OpenMP code for the LUT evaluation.

        Args:
        ------
        - chunk_size: int
            The number of points to process in each OpenMP thread.
        
        Returns:
        --------
        - str
            The generated C++ code.
        """
        self.__generate_cpp_header()
        self.__generate_auxiliary_functions()
        self.__generate_cpp_standard_function()
        self.__generate_cpp_main(file_path)
        return self.cpp_code
    
    def generate_n_points_code(self, chunk_size: int = 10000, file_path:str = '.') -> str:
        """
        Generate the C++ OpenMP code for processing N points in parallel.

        Args:
        ------
        - chunk_size: int
            The number of points to process in each OpenMP thread.
        
        Returns:
        --------
        - str
            The generated C++ code.
        """
        self.__generate_cpp_header()
        self.__generate_auxiliary_functions()
        self.__generate_cpp_n_points_function(chunk_size)
        self.__generate_cpp_n_points_main(chunk_size, file_path)
        return self.cpp_code
    
    def write_code(self, file_path: str) -> str:
        """
        Save the generated C++ code to a file.

        Args:
        ------
        - file_path: str
            The path to save the C++ code.
        """
        with open(file_path, 'w') as file:
            file.write(self.cpp_code)
        
        return file_path
    
    def run(self, file_path:str ,
            method:str = "1_point", 
            chunk_size:int = 10000,
            prune_vector:str = "pruning_vectors.csv",
            save_output:bool = False) -> str:
        """
        Generate and save the C++ code for the LUT evaluation.

        Args:
        ------
        - file_path: str
            The path to save the C++ code.
        - method: str
            The evaluation method to use ("1_point", "n_points" or "pruned).
        - chunk_size: int
            The number of points to process in each OpenMP thread.
        """

        if method == "1_point":
            self.generate_code(chunk_size, file_path, save_output)
        elif method == "n_points":
            self.generate_n_points_code(chunk_size, file_path)
        elif method == "pruned":
            self.generate_pruned_code(prune_vector)
        else:
            self.mensage.error("Invalid evaluation method. Use '1_point', 'n_points' or 'pruned'.")
        
        file_path = self.write_code(file_path)
        self.mensage.success(f"C++ code generation complete., code saved to {file_path}")

        return file_path
