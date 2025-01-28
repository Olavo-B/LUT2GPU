#include <stdio.h>
#include <cuda_runtime.h>
#include <stdlib.h>

// Utility function to check CUDA errors
#define CHECK_CUDA_ERROR(call) { \
    cudaError_t err = call; \
    if (err != cudaSuccess) { \
        printf("CUDA error: %s\n", cudaGetErrorString(err)); \
        exit(1); \
    } \
}

__global__ void evaluate_circuit(int *output) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int num_combinations = 1 << 8;
    
    if (idx < num_combinations) {
        int x = idx;

        // Initialize all variables
    unsigned int x3;
    unsigned int x2;
    unsigned int x5;
    unsigned int new_n22;
    unsigned int z0;
    unsigned int new_n32;
    unsigned int new_n24;
    unsigned int new_n34;
    unsigned int z3;
    unsigned int new_n33;
    unsigned int z4;
    unsigned int new_n16;
    unsigned int new_n17;
    unsigned int new_n20;
    unsigned int new_n31;
    unsigned int x6;
    unsigned int new_n26;
    unsigned int x1;
    unsigned int new_n27;
    unsigned int new_n19;
    unsigned int x7;
    unsigned int new_n21;
    unsigned int new_n25;
    unsigned int x4;
    unsigned int z1;
    unsigned int new_n30;
    unsigned int z2;
    unsigned int new_n23;
    unsigned int new_n35;
    unsigned int x0;
    unsigned int new_n18;
    unsigned int new_n29;

        // Set input values
        x7 = (x >> 0) & 1;
        x6 = (x >> 1) & 1;
        x5 = (x >> 2) & 1;
        x4 = (x >> 3) & 1;
        x3 = (x >> 4) & 1;
        x2 = (x >> 5) & 1;
        x1 = (x >> 6) & 1;
        x0 = (x >> 7) & 1;

        // Evaluate circuit in topological order
        new_n34 = ((1U) >> ((x2 << 1) + (x3 << 0)) & 1);
        new_n20 = ((6U) >> ((x0 << 1) + (x4 << 0)) & 1);
        new_n23 = ((8U) >> ((x0 << 1) + (x4 << 0)) & 1);
        new_n27 = ((839917568U) >> ((x0 << 4) + (x5 << 3) + (x4 << 2) + (x2 << 1) + (x1 << 0)) & 1);
        new_n24 = ((2155905024U) >> ((x0 << 4) + (x4 << 3) + (x2 << 2) + (x1 << 1) + (x6 << 0)) & 1);
        new_n26 = ((18560895U) >> ((x0 << 4) + (x5 << 3) + (x6 << 2) + (x4 << 1) + (x1 << 0)) & 1);
        new_n17 = ((67453077U) >> ((x2 << 4) + (x1 << 3) + (x7 << 2) + (x6 << 1) + (x0 << 0)) & 1);
        new_n18 = ((4214882069U) >> ((x6 << 4) + (x4 << 3) + (x2 << 2) + (x7 << 1) + (x1 << 0)) & 1);
        new_n21 = ((2671239167U) >> ((x1 << 4) + (x5 << 3) + (x6 << 2) + (x7 << 1) + (x2 << 0)) & 1);
        new_n30 = ((8U) >> ((x3 << 1) + (x7 << 0)) & 1);
        new_n32 = ((2192179754U) >> ((x1 << 4) + (x2 << 3) + (x6 << 2) + (x7 << 1) + (x3 << 0)) & 1);
        new_n35 = ((1919U) >> ((x2 << 3) + (x6 << 2) + (x3 << 1) + (x7 << 0)) & 1);
        z4 = ((6U) >> ((x3 << 1) + (x7 << 0)) & 1);
        new_n22 = ((1079002196U) >> ((x1 << 4) + (x7 << 3) + (new_n24 << 2) + (new_n23 << 1) + (x5 << 0)) & 1);
        new_n25 = ((2699097585U) >> ((new_n23 << 4) + (new_n26 << 3) + (x3 << 2) + (x2 << 1) + (new_n27 << 0)) & 1);
        // new_n16 = ((134785544U) >> ((new_n17 << 4) + (x4 << 3) + (new_n18 << 2) + (x0 << 1) + (x5 << 0)) & 1);
        new_n16 = x5 & ((~new_n18 & x0) | (~new_n17 & x4));
        new_n19 = ((2U) >> ((new_n21 << 1) + (new_n20 << 0)) & 1);
        new_n29 = ((2728929416U) >> ((new_n30 << 4) + (x2 << 3) + (x6 << 2) + (x5 << 1) + (x1 << 0)) & 1);
        z3 = ((150U) >> ((new_n30 << 2) + (x2 << 1) + (x6 << 0)) & 1);
        new_n31 = ((572530720U) >> ((x6 << 4) + (x2 << 3) + (x3 << 2) + (new_n32 << 1) + (x5 << 0)) & 1);
        new_n33 = ((2290745352U) >> ((x1 << 4) + (new_n34 << 3) + (new_n35 << 2) + (x5 << 1) + (new_n20 << 0)) & 1);
        z2 = ((105U) >> ((new_n35 << 2) + (x1 << 1) + (x5 << 0)) & 1);
        z0 = ((3722304981U) >> ((new_n22 << 4) + (new_n16 << 3) + (new_n19 << 2) + (x3 << 1) + (new_n25 << 0)) & 1);
        z1 = ((21844U) >> ((new_n29 << 3) + (new_n20 << 2) + (new_n31 << 1) + (new_n33 << 0)) & 1);

        // Combine outputs into a single integer
        output[idx] = 0;
        output[idx] |= (z4 << 0);
        output[idx] |= (z3 << 1);
        output[idx] |= (z2 << 2);
        output[idx] |= (z1 << 3);
        output[idx] |= (z0 << 4);
        

    }
}


int main() {
    // Calculate number of input combinations
    const int num_inputs = 8;
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
    int blocksPerGrid = (num_combinations + threadsPerBlock - 1) / threadsPerBlock;
    
    // Record start time
    cudaEventRecord(start);
    
    // Launch kernel
    evaluate_circuit<<<1024*1024, threadsPerBlock>>>(d_output);
    CHECK_CUDA_ERROR(cudaGetLastError());
    
    // Record stop time
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    
    // Calculate elapsed time
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);
    
    // Copy result back to host
    cudaDeviceSynchronize();
    CHECK_CUDA_ERROR(cudaMemcpy(h_output, d_output, output_size, cudaMemcpyDeviceToHost));
    
    // Print timing information
    printf("\nGPU Execution time: %.3f milliseconds\n", milliseconds);
    
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
                printf("\nInvalid Results:\n");
                printf("Inputs");
                for (int k = 0; k < 2; k++) {
                    printf("\t");
                }
                printf("-> Output | Expected\n");
                header_printed = true;
            }
            
            // Print input combinations
            for (int j = num_inputs - 1; j >= 0; j--) {
                printf("%d ", (i >> j) & 1);
            }
            printf("\t-> ");
            
            // Print output values
            for (int j = 4; j >= 0; j--) {
                printf("%d", (actual_output >> j) & 1);
            }
            
            printf(" | Expected: %d, Got: %d\n", expected_sum, actual_output);
        }
    }
    
    // Print message if no invalid results were found
    if (!header_printed) {
        printf("\nAll results are valid!\n");
    }
    
    // Cleanup
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    free(h_output);
    cudaFree(d_output);
    
    return 0;
}


