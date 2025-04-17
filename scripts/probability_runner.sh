#!/bin/bash

# Function to display script usage
print_usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -b, --benchmark      Benchmark to use (default: c880)"
    echo "  -p, --probabilities  Range of probabilities to test (e.g., 1-100 or 1,5,10,15)"
    echo "  -e, --error-bound    Error bound threshold (default: 0.05)"
    echo "  -o, --output-dir     Base directory for results (default: results/probability_results)"
    echo "  -v, --verilog-dir    Directory containing Verilog files (default: misc/data/Benchmarks/ISCAS85)"
    echo "  -f, --error-function Error function file (default: misc/error_functions/default.txt)"
    echo "  -l, --lut-size       LUT size to use (default: 4)"
    echo "  -n, --num-runs       Number of runs for each probability (default: 2)"
    echo "  -m, --method         Method to use for simulation (default: pruned)"
    echo "  --timeout            Set timeout in seconds (default: 3600, 0 for no timeout)"
    echo "  --debug              Enable debug output"
    echo "  -h, --help           Display this help message"
}

# Function to cleanup processes and files
cleanup() {
    local pids_to_kill=("$@")
    echo -e "\nCleaning up processes..."
    
    # Kill the entire process group to ensure all child processes are terminated
    if [ ${#pids_to_kill[@]} -gt 0 ]; then
        for pid in "${pids_to_kill[@]}"; do
            if ps -p "$pid" > /dev/null; then
                # Kill the process group
                pkill -TERM -P "$pid" 2>/dev/null
                kill -TERM -"$pid" 2>/dev/null
                kill -TERM "$pid" 2>/dev/null
            fi
        done
    fi

    # Remove temporary script if it exists
    [ -f "$temp_script" ] && rm "$temp_script"
}

# Function to handle Ctrl+C
handle_interrupt() {
    echo -e "\nReceived interrupt signal."
    cleanup "${current_pids[@]}"
    echo "Script terminated by user"
    exit 130
}

# Set up trap for Ctrl+C and SIGTERM
trap handle_interrupt SIGINT SIGTERM

# Function to check if python script exists
check_python_script() {
    if [ ! -f "src/flexible-verilog-runner.py" ]; then
        echo "Error: flexible-verilog-runner.py not found in src directory"
        exit 1
    fi
}

# Function to validate directory
validate_directory() {
    if [ ! -d "$1" ]; then
        echo "Error: Directory '$1' does not exist"
        exit 1
    fi
}

# Function to validate benchmark
validate_benchmark() {
    if [ ! -d "$VERILOG_DIR/$1" ]; then
        echo "Error: Benchmark directory '$VERILOG_DIR/$1' does not exist"
        exit 1
    fi

    if [ -f "$VERILOG_DIR/$1/$1.v" ]; then
        DESIGN_FILE="$1.v"
    elif [ -f "$VERILOG_DIR/$1/$1.blif" ]; then
        DESIGN_FILE="$1.blif"
    else
        echo "Error: Neither Verilog (.v) nor BLIF (.blif) file found at '$VERILOG_DIR/$1/'"
        exit 1
    fi
}

# Function to validate error function file or default to ER
validate_error_function() {
    if [ $1 != 'ER' ]; then
        echo "Error: Error function '$1' is not supported. Use 'ER' or provide a valid file."
    elif [ $1 == 'ER' ]; then
        ERROR_FUNCTION="ER"
    elif [ ! -f "$1" ]; then
        echo "Error: Error function file '$1' does not exist"
        exit 1
    fi
}

# Function to expand probability range
expand_probabilities() {
    local range="$1"
    local probabilities=()

    # Check if it's a range (contains dash)
    if [[ $range == *-* ]]; then
        local start_prob=${range%-*}
        local end_prob=${range#*-}
        
        # Validate start and end are numbers
        if ! [[ $start_prob =~ ^[0-9]+$ ]] || ! [[ $end_prob =~ ^[0-9]+$ ]]; then
            echo "Error: Invalid probability range format. Use start-end (e.g., 1-100)."
            exit 1
        fi
        
        # Generate sequence
        for ((i=start_prob; i<=end_prob; i++)); do
            probabilities+=($i)
        done
    else
        # It's a comma-separated list
        IFS=',' read -r -a probabilities <<< "$range"
        
        # Validate all values are numbers
        for prob in "${probabilities[@]}"; do
            if ! [[ $prob =~ ^[0-9]+$ ]]; then
                echo "Error: Invalid probability value '$prob'. Must be a number."
                exit 1
            fi
        done
    fi
    
    echo "${probabilities[@]}"
}

# Function to process each probability
process_probability() {
    local prob="$1"
    local benchmark="$2"
    local test_name="prob_${prob}"
    
    echo "Processing probability: $prob% for benchmark $benchmark"
    
    # Create a temporary script for the Python command
    temp_script=$(mktemp)
    
    echo "python3 src/flexible-verilog-runner.py \
        -v \"$VERILOG_DIR/$benchmark/$DESIGN_FILE\" \
        -t \"$benchmark\" \
        --cuda \
        --method \"$METHOD\" \
        --name \"$test_name\" \
        --probability \"$prob\" \
        --num-runs \"$NUM_RUNS\" \
        --output \"$BASE_DIR\" \
        --lut-size \"$LUT_SIZE\" \
        --error-function \"$ERROR_FUNCTION\" \
        $DEBUG" > "$temp_script"
    
    chmod +x "$temp_script"
    
    # Run with or without timeout based on TIMEOUT_VALUE
    if [ "$TIMEOUT_VALUE" -gt 0 ]; then
        timeout "$TIMEOUT_VALUE" setsid bash "$temp_script" &
    else
        setsid bash "$temp_script" &
    fi
    
    local current_pid=$!
    current_pids+=($current_pid)
    
    wait $current_pid
    local result=$?
    
    # Remove the PID from the array
    current_pids=("${current_pids[@]/$current_pid}")
    
    # Clean up temporary script
    rm "$temp_script"
    
    # Check timeout result
    if [ $result -eq 124 ]; then
        echo "Process timed out after $TIMEOUT_VALUE seconds"
        return 1
    elif [ $result -ne 0 ]; then
        echo "Process failed with exit code $result"
        return $result
    fi
    
    # Analyze results bold
    echo -e "\033[1mAnalyzing results for probability $prob%...\033[0m"
    analyze_results "$BASE_DIR/$test_name/cuda/results.csv" "$prob"
    
    return $?
}

# Function to analyze results
analyze_results() {
    local results_path="$1"
    local probability="$2"
    
    # Check if results file exists
    if [ ! -f "$results_path" ]; then
        echo "Error: Results file not found: $results_path"
        return 1
    fi
    
    # Extract data using Python (similar to analyze_results in the original Python script)
    python3 -c "
import pandas as pd
import csv
from datetime import datetime

from src.ultils.style import Mensage

mensage = Mensage()

# Read the CSV file
df = pd.read_csv('$results_path')


# Get non-zero results
non_zero = df[df['match_count'] > 0]

# Initialize results
result_data = None

# Process results
if len(non_zero) == 0:
    print('No non-zero results found')
    exit(1)
else:
    num_comparisons = 2**18
    
    # Calculate statistics
    best_idx = non_zero['thread_index'].iloc[non_zero['match_count'].argmax()]
    best_result = non_zero['match_count'].max()
    er = (num_comparisons - best_result) / num_comparisons
    q0 = non_zero['match_count'].quantile(0.02)
    q1 = non_zero['match_count'].quantile(0.25)
    q2 = non_zero['match_count'].median()
    q3 = non_zero['match_count'].quantile(0.75)
    q4 = non_zero['match_count'].quantile(0.98)
    min_val = non_zero['match_count'].min()
    non_zero_count = len(non_zero)
    percentage_non_zero = non_zero_count / len(df) * 100
    
    print(f'    Best thread: {best_idx}')
    print(f'    Best result: {best_result}')
    print(f'    Error rate: {er:.6f}')
    print(f'    Q0 (2%): {q0}')
    print(f'    Q1 (25%): {q1}')
    print(f'    Q2 (50%): {q2}')
    print(f'    Q3 (75%): {q3}')
    print(f'    Q4 (98%): {q4}')
    print(f'    Min value: {min_val}')
    print(f'    Non-zero count: {non_zero_count}')
    print(f'    Percentage non-zero: {percentage_non_zero:.2f}%')
    
    # Check error bound
    if er > $ERROR_BOUND:
        mensage.warning(f'Error rate {er:.6f} exceeds bound {$ERROR_BOUND}')
        exit(2)
    
    # Append to analysis CSV
    with open('$BASE_DIR/probability_analysis.csv', 'a', newline='') as f:
        writer = csv.writer(f)
        writer.writerow([
            datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            '$probability',
            best_idx,
            best_result,
            er,
            q0,
            q1,
            q2,
            q3,
            q4,
            min_val,
            non_zero_count,
            percentage_non_zero
        ])
    
    print('\\nResults saved to probability_analysis.csv')
" || return $?

    return 0
}

# Initialize variables with default values
BENCHMARK="c880"
PROB_RANGE="1-100"
ERROR_BOUND=0.05
BASE_DIR="results/probability_results"
VERILOG_DIR="misc/data/Benchmarks/ISCAS85"
ERROR_FUNCTION="ER"
LUT_SIZE=4
NUM_RUNS=2
METHOD="pruned"
TIMEOUT_VALUE=3600
DEBUG=""
declare -a current_pids=()

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -b|--benchmark)
            BENCHMARK="$2"
            shift 2
            ;;
        -p|--probabilities)
            PROB_RANGE="$2"
            shift 2
            ;;
        -e|--error-bound)
            ERROR_BOUND="$2"
            shift 2
            ;;
        -o|--output-dir)
            BASE_DIR="results/probability_results_$2"
            shift 2
            ;;
        -v|--verilog-dir)
            VERILOG_DIR="$2"
            shift 2
            ;;
        -f|--error-function)
            ERROR_FUNCTION="$2"
            shift 2
            ;;
        -l|--lut-size)
            LUT_SIZE="$2"
            shift 2
            ;;
        -n|--num-runs)
            NUM_RUNS="$2"
            shift 2
            ;;
        -m|--method)
            METHOD="$2"
            shift 2
            ;;
        --timeout)
            TIMEOUT_VALUE="$2"
            shift 2
            ;;
        --debug)
            DEBUG="--debug"
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "Error: Unknown option $1"
            print_usage
            exit 1
            ;;
    esac
done

# Validate inputs
check_python_script
validate_directory "$VERILOG_DIR"
validate_benchmark "$BENCHMARK"
validate_error_function "$ERROR_FUNCTION"

# Create output base directory with benchmark name
BASE_DIR="${BASE_DIR}_${BENCHMARK}"
echo "Results will be saved to: $BASE_DIR"
mkdir -p "$BASE_DIR"

# Create output CSV file
results_csv="$BASE_DIR/probability_analysis.csv"
echo "Creating results file: $results_csv"
echo "timestamp,percentage,best_thread_id,best_result,percentage_best,q0,q1,q2,q3,q4,min,non_zero_count,percentage_non_zero" > "$results_csv"

# Expand probabilities
probabilities=($(expand_probabilities "$PROB_RANGE"))
echo "Processing ${#probabilities[@]} probability values: ${probabilities[*]}"

# Process each probability
count=0
success=0
timeout_count=0
failed=0
error_bound_exceeded=0

for prob in "${probabilities[@]}"; do
    count=$((count + 1))
    echo ""
    echo "[$count/${#probabilities[@]}] Processing probability $prob%"
    
    # Process probability
    process_probability "$prob" "$BENCHMARK"
    result=$?
    
    if [ $result -eq 0 ]; then
        echo "Successfully processed probability $prob%"
        success=$((success + 1))
    elif [ $result -eq 1 ]; then
        echo "Process timed out for probability $prob%"
        timeout_count=$((timeout_count + 1))
    elif [ $result -eq 2 ]; then
        echo "Error bound exceeded for probability $prob%"
        error_bound_exceeded=$((error_bound_exceeded + 1))
        exit 2
    else
        echo "Process failed for probability $prob%"
        failed=$((failed + 1))
    fi
    
    # Small delay between runs to ensure file system operations complete
    sleep 1
done

echo ""
echo "Processing complete. Summary:"
echo "Total probability values processed: $count"
echo "Successfully completed: $success"
echo "Timed out: $timeout_count"
echo "Failed: $failed"
echo "Error bound exceeded: $error_bound_exceeded"
echo "Results saved to: $results_csv"