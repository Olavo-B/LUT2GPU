#!/bin/bash

# Compile CUDA code with profiling information
nvcc -lineinfo /app/results/blif_generator/circuit_evaluator.cu -o circuit_evaluator

echo "Running basic CUDA profiling..."
nvprof --metrics all ./circuit_evaluator

echo "Running detailed analysis with Nsight Compute..."
ncu --set full --section SpeedOfLight --section MemoryWorkloadAnalysis \
    --section ComputeWorkloadAnalysis ./circuit_evaluator

# Create CSV file for results
echo "timestamp,implementation,execution_time_ms,throughput_combinations_per_sec" > performance_results.csv

# Run CUDA implementation multiple times for averaging
for i in {1..10}; do
    # Get timestamp
    timestamp=$(date +%s)
    
    # Run with timing information
    output=$(./circuit_evaluator)
    
    # Extract execution time using grep and awk
    execution_time=$(echo "$output" | grep "GPU Execution time" | awk '{print $4}')
    
    # Calculate throughput using awk (256 combinations)
    throughput=$(echo "$execution_time" | awk '{print 256.0/($1/1000)}')
    
    # Append to CSV
    echo "$timestamp,cuda,$execution_time,$throughput" >> performance_results.csv
done

echo "Results saved to performance_results.csv"