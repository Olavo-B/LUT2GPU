#!/bin/bash

# Create CSV file if it doesn't exist
if [ ! -f performance_results.csv ]; then
    echo "timestamp,implementation,execution_time_ms,throughput_combinations_per_sec" > performance_results.csv
fi

# Compile Verilog files
iverilog -o somador_sim /app/results/blif_generator/somador.v /app/results/blif_generator/tb_somador.v

# Function to run simulation and measure time
run_simulation() {
    # Use time command to measure execution time
    TIMEFORMAT='%3R'
    execution_time=$( { time vvp somador_sim >/dev/null; } 2>&1 )
    
    # Convert to milliseconds (time returns seconds)
    elapsed=$(echo "$execution_time" | awk '{printf "%.3f", $1 * 1000}')
    
    # Calculate throughput using awk
    throughput=$(echo "$elapsed" | awk '{if ($1 > 0) printf "%.2f", 256.0/($1/1000); else print "N/A"}')
    
    echo "$elapsed,$throughput"
}

# Run simulation multiple times for averaging
echo "Running Verilog simulation profiling..."
for i in {1..10}; do
    # Get timestamp
    timestamp=$(date +%s)
    
    # Run simulation and get timing
    result=$(run_simulation)
    elapsed=$(echo $result | cut -d',' -f1)
    throughput=$(echo $result | cut -d',' -f2)
    
    # Append to CSV
    echo "$timestamp,verilog,$elapsed,$throughput" >> performance_results.csv
    
    echo "Run $i: $elapsed ms (throughput: $throughput combinations/sec)"
done

echo "Results saved to performance_results.csv"

# Calculate and show average
echo -e "\nCalculating averages..."
awk -F',' '
    $2 == "verilog" {
        count++
        sum_time += $3
        if ($4 != "N/A") {
            valid_throughput++
            sum_throughput += $4
        }
    }
    END {
        if (count > 0) 
            printf "Average execution time: %.3f ms\n", sum_time/count
        if (valid_throughput > 0)
            printf "Average throughput: %.2f combinations/sec\n", sum_throughput/valid_throughput
        else
            print "Average throughput: N/A (no valid measurements)"
    }
' performance_results.csv