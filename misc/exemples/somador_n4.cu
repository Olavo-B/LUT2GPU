#include <stdio.h>
#include <cuda_runtime.h>

__global__ void evaluate_circuit(int *output) {
    // Input values fixed: 0 0 1 1 1 1 1 1
    int x0 = 0;
    int x1 = 0;
    int x2 = 1;
    int x3 = 1;
    int x4 = 1;
    int x5 = 1;
    int x6 = 0;
    int x7 = 1;

    // Level 1 calculations
    int new_n34 = 1U >> ((x2 << 1) + (x3 << 0)) & 1;
    int new_n20 = 6U >> ((x0 << 1) + (x4 << 0)) & 1;
    int new_n23 = 8U >> ((x0 << 1) + (x4 << 0)) & 1;
    int new_n27 = 839917568U >> ((x0 << 4) + (x5 << 3) + (x4 << 2) + (x2 << 1) + (x1 << 0)) & 1;
    int new_n24 = 2155905024U >> ((x0 << 4) + (x4 << 3) + (x2 << 2) + (x1 << 1) + (x6 << 0)) & 1;
    int new_n26 = 18560895U >> ((x0 << 4) + (x5 << 3) + (x6 << 2) + (x4 << 1) + (x1 << 0)) & 1;
    int new_n17 = 67453077U >> ((x2 << 4) + (x1 << 3) + (x7 << 2) + (x6 << 1) + (x0 << 0)) & 1;
    int new_n18 = 4214882069U >> ((x6 << 4) + (x4 << 3) + (x2 << 2) + (x7 << 1) + (x1 << 0)) & 1;
    int new_n21 = 2671239167U >> ((x1 << 4) + (x5 << 3) + (x6 << 2) + (x7 << 1) + (x2 << 0)) & 1;
    int new_n30 = 8U >> ((x3 << 1) + (x7 << 0)) & 1;
    int new_n32 = 2192179754U >> ((x1 << 4) + (x2 << 3) + (x6 << 2) + (x7 << 1) + (x3 << 0)) & 1;
    int new_n35 = 1919U >> ((x2 << 3) + (x6 << 2) + (x3 << 1) + (x7 << 0)) & 1;
    
    // First outputs
    int z4 = 6U >> ((x3 << 1) + (x7 << 0)) & 1;
    
    // Level 2 calculations
    int new_n22 = 1079002196U >> ((x1 << 4) + (x7 << 3) + (new_n24 << 2) + (new_n23 << 1) + (x5 << 0)) & 1;
    int new_n25 = 2699097585U >> ((new_n23 << 4) + (new_n26 << 3) + (x3 << 2) + (x2 << 1) + (new_n27 << 0)) & 1;
    int new_n16 = 134785544U >> ((new_n17 << 4) + (x4 << 3) + (new_n18 << 2) + (x0 << 1) + (x5 << 0)) & 1;
    int new_n19 = 2U >> ((new_n21 << 1) + (new_n20 << 0)) & 1;
    int new_n29 = 2728929416U >> ((new_n30 << 4) + (x2 << 3) + (x6 << 2) + (x5 << 1) + (x1 << 0)) & 1;
    int z3 = 150U >> ((new_n30 << 2) + (x2 << 1) + (x6 << 0)) & 1;
    int new_n31 = 572530720U >> ((x6 << 4) + (x2 << 3) + (x3 << 2) + (new_n32 << 1) + (x5 << 0)) & 1;
    int new_n33 = 2290745352U >> ((x1 << 4) + (new_n34 << 3) + (new_n35 << 2) + (x5 << 1) + (new_n20 << 0)) & 1;
    
    // Final outputs
    int z2 = 105U >> ((new_n35 << 2) + (x1 << 1) + (x5 << 0)) & 1;
    int z0 = 3722304981U >> ((new_n22 << 4) + (new_n16 << 3) + (new_n19 << 2) + (x3 << 1) + (new_n25 << 0)) & 1;
    int z1 = 21844U >> ((new_n29 << 3) + (new_n20 << 2) + (new_n31 << 1) + (new_n33 << 0)) & 1;

    // Store results
    output[0] = z0;
    output[1] = z1;
    output[2] = z2;
    output[3] = z3;
    output[4] = z4;

    // Print intermediate values for debugging
    printf("new_n34=%d new_n20=%d new_n23=%d new_n27=%d\n", new_n34, new_n20, new_n23, new_n27);
    printf("new_n24=%d new_n26=%d new_n17=%d new_n18=%d\n", new_n24, new_n26, new_n17, new_n18);
    printf("new_n21=%d new_n30=%d new_n32=%d new_n35=%d\n", new_n21, new_n30, new_n32, new_n35);
    printf("new_n22=%d new_n25=%d new_n16=%d new_n19=%d\n", new_n22, new_n25, new_n16, new_n19);
    printf("new_n29=%d new_n31=%d new_n33=%d\n", new_n29, new_n31, new_n33);
    printf("Final outputs: z0=%d z1=%d z2=%d z3=%d z4=%d\n", z0, z1, z2, z3, z4);
}

int main() {
    int *d_output, h_output[5];
    
    // Allocate device memory
    cudaMalloc(&d_output, 5 * sizeof(int));
    
    // Launch kernel with single thread
    evaluate_circuit<<<1, 1>>>(d_output);
    
    // Copy results back
    cudaDeviceSynchronize();
    cudaMemcpy(h_output, d_output, 5 * sizeof(int), cudaMemcpyDeviceToHost);

    cudaError_t err = cudaGetLastError();
    printf("CUDA Error: %s\n", cudaGetErrorString(err));


    
    // Print final results
    printf("\nFinal results from host:\n");
    printf("z0=%d z1=%d z2=%d z3=%d z4=%d\n", 
           h_output[0], h_output[1], h_output[2], h_output[3], h_output[4]);

    
    // Cleanup
    cudaFree(d_output);
    
    return 0;
}
