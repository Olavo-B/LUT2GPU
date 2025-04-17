#!/bin/bash

# Function to display script usage
print_usage() {
    echo "Usage: $0 [-d directory] [--cuda|--iverilog|--verilator|--all] [options]"
    echo ""
    echo "Required arguments:"
    echo "  -d, --directory    Directory containing Verilog files to process"
    echo ""
    echo "Simulation options:"
    echo "  --cuda            Run only CUDA simulation"
    echo "  --iverilog        Run only Icarus Verilog simulation"
    echo "  --verilator       Run only Verilator simulation"
    echo "  --all             Run all simulations (default)"
    echo ""
    echo "Additional options:"
    echo "  --name            Name prefix for test runs (default: verilog_test)"
    echo "  --top-module     Specify the top module name (default: derived from filename)"
    echo "  --num-runs        Number of performance test runs (default: 5)"
    echo "  --lut-size        Number of LUTs in the FPGA (default: 5)"
    echo "  --cuda-threads    CUDA threads per block (default: 256)"
    echo "  --cuda-blocks     CUDA blocks per grid (default: 768)"
    echo "  --chunk-size      Points per thread (default: 171)"
    echo "  --method          Specify the method to use for simulation"
    echo "  --timeout         Set timeout in seconds (default: 3600, 0 for no timeout)"
    echo "  --profile         Enable CUDA profiling"
    echo "  --error-function   Specify the error function to use (default: ER)"
    echo "  --debug           Enable debug output"
    echo "  -h, --help        Display this help message"
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
        echo "Error: flexible-verilog-runner.py not found in current directory"
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

# Function to process a single file with timeout
process_file() {
    local vfile="$1"
    local module_name="$2"
    local current_test_name="$3"
    
    # Create a temporary script for the Python command
    temp_script=$(mktemp)
    echo "python3 src/flexible-verilog-runner.py \
        -v \"$vfile\" \
        -t \"$module_name\" \
        $SIMULATION_MODE \
        --name \"$current_test_name\" \
        --num-runs \"$NUM_RUNS\" \
        --lut-size \"$NUM_LUTS\" \
        --cuda-threads \"$CUDA_THREADS\" \
        --cuda-blocks \"$CUDA_BLOCKS\" \
        --points-per-thread \"$CHUNK_SIZE\" \
        --method \"$METHOD\" \
        --error-function \"$ERROR_FUNCTION\" \
        $PROFILE \
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
    else
        return $result
    fi
}

# Initialize variables with default values
DIRECTORY=""
SIMULATION_MODE="--all"
TEST_NAME="verilog_test"
NUM_RUNS=5
NUM_LUTS=5
CUDA_THREADS=256
CUDA_BLOCKS=768
CHUNK_SIZE=171
TIMEOUT_VALUE=3600
PROFILE=""
DEBUG=""
ERROR_FUNCTION="ER"
METHOD="1_point"
declare -a current_pids=()

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--directory)
            DIRECTORY="$2"
            shift 2
            ;;
        --cuda|--iverilog|--verilator|--all)
            SIMULATION_MODE="$1"
            shift
            ;;
        --name)
            TEST_NAME="$2"
            shift 2
            ;;
        --top-module)
            TOP_MODULE="$2"
            shift 2
            ;;
        --num-runs)
            NUM_RUNS="$2"
            shift 2
            ;;
        --lut-size)
            NUM_LUTS="$2"
            shift 2
            ;;
        --cuda-threads)
            CUDA_THREADS="$2"
            shift 2
            ;;
        --cuda-blocks)
            CUDA_BLOCKS="$2"
            shift 2
            ;;
        --chunk-size)
            CHUNK_SIZE="$2"
            shift 2
            ;;
        --method)
            METHOD="$2"
            shift 2
            ;;
        --timeout)
            TIMEOUT_VALUE="$2"
            shift 2
            ;;
        --profile)
            PROFILE="--profile"
            shift
            ;;
        --debug)
            DEBUG="--debug"
            shift
            ;;
        --error-function)
            ERROR_FUNCTION="$2"
            shift 2
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

# Check required arguments
if [ -z "$DIRECTORY" ]; then
    echo "Error: Directory is required"
    print_usage
    exit 1
fi

# Validate inputs
check_python_script
validate_directory "$DIRECTORY"

# Find all Verilog files in the directory and subdirectories
echo "Searching for Verilog files in $DIRECTORY..."
VERILOG_FILES=$(find "$DIRECTORY" -type f -name "*.v")

# Check if any Verilog files were found
if [ -z "$VERILOG_FILES" ]; then
    echo "No Verilog files found in $DIRECTORY"
    exit 1
fi

# Process each Verilog file
count=0
success=0
timeout=0
failed=0

for vfile in $VERILOG_FILES; do
    count=$((count + 1))
    echo ""
    echo "Processing file $count: $vfile"

    if [ -n "$TOP_MODULE" ]; then
        MODULE_NAME="$TOP_MODULE"
    else
        # Extract the module name from the filename
        MODULE_NAME=$(basename "$vfile" .v)
        
    fi

    FILE_NAME=$(basename "$vfile" .v)
    # Generate a unique name for this test run
    current_test_name="${TEST_NAME}_${FILE_NAME}"
    
    echo "Using module name: $MODULE_NAME"
    if [ "$TIMEOUT_VALUE" -gt 0 ]; then
        echo "Starting process ($TIMEOUT_VALUE seconds timeout)..."
    else
        echo "Starting process (no timeout)..."
    fi
    
    # Process file with timeout
    if process_file "$vfile" "$MODULE_NAME" "$current_test_name"; then
        echo "Successfully processed $vfile"
        success=$((success + 1))
    else
        if [ $? -eq 124 ]; then
            echo "Processing timed out for $vfile"
            timeout=$((timeout + 1))
        else
            echo "Processing failed for $vfile"
            failed=$((failed + 1))
        fi
    fi
done

echo ""
echo "Processing complete. Summary:"
echo "Total files processed: $count"
echo "Successfully completed: $success"
echo "Timed out: $timeout"
echo "Failed: $failed"