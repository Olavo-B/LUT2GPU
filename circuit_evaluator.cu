
#include <stdio.h>
#include <cuda_runtime.h>
#include <stdlib.h>

// Utility function to check CUDA errors
#define CHECK_CUDA_ERROR(call) {     cudaError_t err = call;     if (err != cudaSuccess) {         printf("CUDA error: %s\n", cudaGetErrorString(err));         exit(1);     } }

__global__ void evaluate_circuit(int *output) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int num_combinations = 1 << 10;
    
    if (idx < num_combinations) {
        int x = idx;

        // Initialize all variables
        int z2 = 0;
        int z4 = 0;
        int new_n38 = 0;
        int new_n58 = 0;
        int new_n61 = 0;
        int new_n27 = 0;
        int new_n84 = 0;
        int new_n48 = 0;
        int new_n53 = 0;
        int x0 = 0;
        int x4 = 0;
        int z0 = 0;
        int new_n26 = 0;
        int new_n36 = 0;
        int new_n87 = 0;
        int new_n23 = 0;
        int new_n56 = 0;
        int new_n21 = 0;
        int new_n40 = 0;
        int new_n71 = 0;
        int new_n59 = 0;
        int new_n70 = 0;
        int new_n91 = 0;
        int new_n88 = 0;
        int new_n77 = 0;
        int new_n90 = 0;
        int new_n47 = 0;
        int x2 = 0;
        int new_n42 = 0;
        int z1 = 0;
        int new_n57 = 0;
        int new_n55 = 0;
        int new_n52 = 0;
        int new_n68 = 0;
        int new_n80 = 0;
        int new_n72 = 0;
        int new_n28 = 0;
        int new_n39 = 0;
        int new_n30 = 0;
        int new_n51 = 0;
        int new_n45 = 0;
        int new_n81 = 0;
        int new_n86 = 0;
        int new_n85 = 0;
        int x9 = 0;
        int new_n75 = 0;
        int new_n44 = 0;
        int new_n35 = 0;
        int new_n25 = 0;
        int new_n32 = 0;
        int new_n29 = 0;
        int z3 = 0;
        int new_n43 = 0;
        int x8 = 0;
        int new_n54 = 0;
        int new_n89 = 0;
        int new_n34 = 0;
        int x1 = 0;
        int new_n78 = 0;
        int new_n60 = 0;
        int x6 = 0;
        int new_n24 = 0;
        int new_n74 = 0;
        int new_n31 = 0;
        int new_n20 = 0;
        int new_n69 = 0;
        int z5 = 0;
        int new_n82 = 0;
        int x7 = 0;
        int new_n83 = 0;
        int new_n76 = 0;
        int new_n63 = 0;
        int new_n66 = 0;
        int new_n67 = 0;
        int new_n50 = 0;
        int x3 = 0;
        int new_n79 = 0;
        int new_n41 = 0;
        int new_n62 = 0;
        int new_n46 = 0;
        int new_n19 = 0;
        int new_n65 = 0;
        int new_n64 = 0;
        int x5 = 0;
        int new_n22 = 0;
        int new_n37 = 0;
        int new_n33 = 0;
        int new_n49 = 0;

        // Set input values
        x9 = (x >> 0) & 1;
        x8 = (x >> 1) & 1;
        x7 = (x >> 2) & 1;
        x6 = (x >> 3) & 1;
        x5 = (x >> 4) & 1;
        x4 = (x >> 5) & 1;
        x3 = (x >> 6) & 1;
        x2 = (x >> 7) & 1;
        x1 = (x >> 8) & 1;
        x0 = (x >> 9) & 1;

        // Evaluate circuit in topological order
        new_n48 = 57585 >> ((x3 << 3) + (x2 << 2) + (x1 << 1) + (x4 << 0)) & 1;
        new_n51 = 1 >> ((x3 << 1) + (x4 << 0)) & 1;
        new_n62 = 8 >> ((x2 << 1) + (x4 << 0)) & 1;
        new_n71 = 128 >> ((x3 << 3) + (x2 << 2) + (x1 << 1) + (x4 << 0)) & 1;
        new_n79 = 9 >> ((x0 << 1) + (x5 << 0)) & 1;
        new_n72 = 43682 >> ((x7 << 3) + (x4 << 2) + (x2 << 1) + (x1 << 0)) & 1;
        new_n90 = 1431393360 >> ((x1 << 4) + (x7 << 3) + (x3 << 2) + (x2 << 1) + (x4 << 0)) & 1;
        new_n22 = 8 >> ((x7 << 1) + (x8 << 0)) & 1;
        new_n28 = 1644825 >> ((x3 << 4) + (x8 << 3) + (x4 << 2) + (x7 << 1) + (x0 << 0)) & 1;
        new_n29 = 2863278762 >> ((x4 << 4) + (x7 << 3) + (x8 << 2) + (x3 << 1) + (x2 << 0)) & 1;
        new_n43 = 352343360 >> ((x0 << 4) + (x7 << 3) + (x3 << 2) + (x8 << 1) + (x4 << 0)) & 1;
        new_n89 = 537395754 >> ((x1 << 4) + (x7 << 3) + (x8 << 2) + (x2 << 1) + (x3 << 0)) & 1;
        new_n91 = 526344 >> ((x3 << 4) + (x8 << 3) + (x7 << 2) + (x1 << 1) + (x2 << 0)) & 1;
        new_n24 = 2423937146 >> ((x9 << 4) + (x4 << 3) + (x7 << 2) + (x8 << 1) + (x3 << 0)) & 1;
        new_n27 = 117938047 >> ((x0 << 4) + (x9 << 3) + (x3 << 2) + (x7 << 1) + (x8 << 0)) & 1;
        new_n31 = 32768 >> ((x4 << 3) + (x7 << 2) + (x8 << 1) + (x9 << 0)) & 1;
        new_n33 = 128 >> ((x7 << 2) + (x8 << 1) + (x9 << 0)) & 1;
        new_n35 = 1360072977 >> ((x8 << 4) + (x9 << 3) + (x4 << 2) + (x7 << 1) + (x3 << 0)) & 1;
        new_n36 = 1938919825 >> ((x4 << 4) + (x9 << 3) + (x3 << 2) + (x7 << 1) + (x8 << 0)) & 1;
        new_n38 = 2507612031 >> ((x2 << 4) + (x3 << 3) + (x7 << 2) + (x8 << 1) + (x9 << 0)) & 1;
        new_n42 = 2111774983 >> ((x0 << 4) + (x3 << 3) + (x7 << 2) + (x9 << 1) + (x8 << 0)) & 1;
        new_n45 = 2939123583 >> ((x2 << 4) + (x9 << 3) + (x8 << 2) + (x7 << 1) + (x4 << 0)) & 1;
        new_n47 = 1877409792 >> ((x3 << 4) + (x9 << 3) + (x7 << 2) + (x8 << 1) + (x4 << 0)) & 1;
        new_n50 = 155 >> ((x9 << 2) + (x3 << 1) + (x4 << 0)) & 1;
        new_n55 = 2148075785 >> ((x4 << 4) + (x9 << 3) + (x6 << 2) + (x8 << 1) + (x2 << 0)) & 1;
        new_n56 = 526344 >> ((x4 << 4) + (x9 << 3) + (x6 << 2) + (x8 << 1) + (x2 << 0)) & 1;
        new_n57 = 1161839872 >> ((x9 << 4) + (x6 << 3) + (x2 << 2) + (x4 << 1) + (x7 << 0)) & 1;
        new_n59 = 2964371632 >> ((x6 << 4) + (x9 << 3) + (x7 << 2) + (x4 << 1) + (x8 << 0)) & 1;
        new_n63 = 2266441535 >> ((x9 << 4) + (x8 << 3) + (x2 << 2) + (x7 << 1) + (x4 << 0)) & 1;
        new_n64 = 128 >> ((x4 << 2) + (x8 << 1) + (x9 << 0)) & 1;
        new_n67 = 3952851867 >> ((x9 << 4) + (x4 << 3) + (x8 << 2) + (x2 << 1) + (x3 << 0)) & 1;
        new_n68 = 8 >> ((x7 << 3) + (x9 << 2) + (x8 << 1) + (x3 << 0)) & 1;
        new_n77 = 18191637 >> ((x9 << 4) + (x4 << 3) + (x3 << 2) + (x8 << 1) + (x7 << 0)) & 1;
        new_n81 = 63616 >> ((x3 << 3) + (x8 << 2) + (x4 << 1) + (x9 << 0)) & 1;
        new_n86 = 86070677 >> ((x8 << 4) + (x1 << 3) + (x3 << 2) + (x9 << 1) + (x7 << 0)) & 1;
        new_n87 = 3959357845 >> ((x2 << 4) + (x3 << 3) + (x8 << 2) + (x9 << 1) + (x1 << 0)) & 1;
        z4 = 38502 >> ((x4 << 3) + (x9 << 2) + (x3 << 1) + (x8 << 0)) & 1;
        z5 = 6 >> ((x4 << 1) + (x9 << 0)) & 1;
        new_n70 = 8 >> ((x8 << 2) + (x7 << 1) + (new_n71 << 0)) & 1;
        new_n82 = 4433 >> ((x2 << 3) + (new_n51 << 2) + (x6 << 1) + (new_n79 << 0)) & 1;
        new_n21 = 4146 >> ((x2 << 3) + (x3 << 2) + (new_n22 << 1) + (x4 << 0)) & 1;
        new_n23 = 2147518472 >> ((x2 << 4) + (x3 << 3) + (x9 << 2) + (x4 << 1) + (new_n22 << 0)) & 1;
        new_n88 = 8706 >> ((new_n89 << 3) + (new_n90 << 2) + (new_n91 << 1) + (new_n79 << 0)) & 1;
        new_n26 = 8706 >> ((new_n27 << 3) + (x4 << 2) + (new_n28 << 1) + (new_n29 << 0)) & 1;
        new_n30 = 1297958229 >> ((new_n31 << 4) + (new_n22 << 3) + (x3 << 2) + (x0 << 1) + (x4 << 0)) & 1;
        new_n58 = 1414813012 >> ((x4 << 4) + (x6 << 3) + (new_n31 << 2) + (x2 << 1) + (x3 << 0)) & 1;
        new_n32 = 353703173 >> ((new_n33 << 4) + (x0 << 3) + (x4 << 2) + (x3 << 1) + (x2 << 0)) & 1;
        new_n69 = 131586 >> ((x2 << 4) + (x7 << 3) + (x3 << 2) + (new_n33 << 1) + (x4 << 0)) & 1;
        new_n34 = 2 >> ((new_n35 << 3) + (new_n36 << 2) + (x0 << 1) + (x2 << 0)) & 1;
        new_n37 = 587281169 >> ((new_n22 << 4) + (new_n38 << 3) + (x3 << 2) + (x0 << 1) + (x4 << 0)) & 1;
        new_n41 = 34984 >> ((new_n42 << 3) + (x4 << 2) + (new_n43 << 1) + (x2 << 0)) & 1;
        new_n44 = 8 >> ((new_n45 << 2) + (x3 << 1) + (x4 << 0)) & 1;
        new_n46 = 572662434 >> ((new_n35 << 4) + (new_n47 << 3) + (x1 << 2) + (x2 << 1) + (new_n48 << 0)) & 1;
        new_n49 = 3217006015 >> ((new_n50 << 4) + (new_n22 << 3) + (new_n51 << 2) + (x0 << 1) + (x1 << 0)) & 1;
        new_n78 = 2 >> ((new_n50 << 2) + (x2 << 1) + (new_n22 << 0)) & 1;
        new_n54 = 2829626024 >> ((new_n55 << 4) + (x7 << 3) + (new_n56 << 2) + (new_n57 << 1) + (x3 << 0)) & 1;
        new_n61 = 3822 >> ((new_n62 << 3) + (new_n33 << 2) + (new_n63 << 1) + (x1 << 0)) & 1;
        new_n66 = 4539717 >> ((new_n68 << 4) + (new_n62 << 3) + (x7 << 2) + (new_n67 << 1) + (x1 << 0)) & 1;
        new_n76 = 3149597627 >> ((new_n45 << 4) + (x3 << 3) + (x4 << 2) + (x2 << 1) + (new_n77 << 0)) & 1;
        new_n80 = 3907578048 >> ((x3 << 4) + (x4 << 3) + (x2 << 2) + (x7 << 1) + (new_n81 << 0)) & 1;
        new_n84 = 4008675461 >> ((x7 << 4) + (x3 << 3) + (x4 << 2) + (new_n81 << 1) + (x2 << 0)) & 1;
        z3 = 150 >> ((new_n81 << 2) + (x2 << 1) + (x7 << 0)) & 1;
        new_n85 = 3795907409 >> ((x1 << 4) + (new_n86 << 3) + (new_n87 << 2) + (x7 << 1) + (x2 << 0)) & 1;
        new_n20 = 33685506 >> ((new_n24 << 4) + (x2 << 3) + (new_n21 << 2) + (new_n23 << 1) + (x0 << 0)) & 1;
        new_n25 = 1364284753 >> ((new_n30 << 4) + (new_n32 << 3) + (new_n26 << 2) + (x1 << 1) + (new_n34 << 0)) & 1;
        new_n40 = 1372672499 >> ((new_n44 << 4) + (new_n41 << 3) + (new_n46 << 2) + (x0 << 1) + (x1 << 0)) & 1;
        new_n53 = 2829623464 >> ((new_n59 << 4) + (x2 << 3) + (new_n54 << 2) + (new_n58 << 1) + (x1 << 0)) & 1;
        new_n60 = 3722284509 >> ((x1 << 4) + (x2 << 3) + (new_n64 << 2) + (new_n61 << 1) + (x3 << 0)) & 1;
        new_n65 = 1364284753 >> ((new_n69 << 4) + (new_n72 << 3) + (new_n66 << 2) + (x6 << 1) + (new_n70 << 0)) & 1;
        new_n75 = 2155905160 >> ((x6 << 4) + (new_n76 << 3) + (new_n78 << 2) + (x1 << 1) + (new_n79 << 0)) & 1;
        z2 = 150 >> ((new_n80 << 2) + (x1 << 1) + (x6 << 0)) & 1;
        new_n83 = 34954 >> ((x1 << 3) + (new_n84 << 2) + (new_n79 << 1) + (x6 << 0)) & 1;
        new_n19 = 572662314 >> ((new_n37 << 4) + (x1 << 3) + (new_n20 << 2) + (new_n25 << 1) + (x6 << 0)) & 1;
        new_n39 = 61152 >> ((new_n40 << 3) + (x6 << 2) + (x2 << 1) + (new_n49 << 0)) & 1;
        new_n52 = 2728566946 >> ((new_n60 << 4) + (x6 << 3) + (x5 << 2) + (new_n53 << 1) + (new_n65 << 0)) & 1;
        new_n74 = 1162167557 >> ((new_n80 << 4) + (x6 << 3) + (new_n82 << 2) + (x1 << 1) + (new_n75 << 0)) & 1;
        z0 = 3132764346 >> ((new_n19 << 4) + (new_n39 << 3) + (x0 << 2) + (new_n52 << 1) + (x5 << 0)) & 1;
        z1 = 993770299 >> ((new_n85 << 4) + (x4 << 3) + (new_n88 << 2) + (new_n74 << 1) + (new_n83 << 0)) & 1;

        // Combine outputs into a single integer
        output[idx] = 0;
        output[idx] |= (z5 << 0);
        output[idx] |= (z4 << 1);
        output[idx] |= (z3 << 2);
        output[idx] |= (z2 << 3);
        output[idx] |= (z1 << 4);
        output[idx] |= (z0 << 5);
    }
}


int main() {
    // Calculate number of input combinations
    const int num_inputs = 10;
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
    int threadsPerBlock = 256;
    int blocksPerGrid = (num_combinations + threadsPerBlock - 1) / threadsPerBlock;
    
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
    printf("\nGPU Execution time: %.3f milliseconds\n", milliseconds);
    
    // Print truth table header
    printf("\nCircuit Truth Table and Validation:\n");
    printf("Inputs");
    for (int i = 0; i < 3.3333333333333335; i++) {
        printf("\t");
    }
    printf("-> Outputs|Valid?\n");
    
    // Print results and validate
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
        
        // Print input combinations
        for (int j = num_inputs - 1; j >= 0; j--) {
            printf("%d ", (i >> j) & 1);
        }
        printf("\t-> ");
        
        // Print output values
        for (int j = 5; j >= 0; j--) {
            printf("%d", (actual_output >> j) & 1);
        }
        
        // Validate and print result
        if (actual_output != expected_sum) {
            printf(" | INVALID! Expected: %d, Got: %d", expected_sum, actual_output);
        } else {
            printf(" | Valid");
        }
        printf("\n");
    }
    
    // Cleanup
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    free(h_output);
    cudaFree(d_output);
    
    return 0;
}
