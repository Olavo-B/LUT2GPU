#!/bin/bash

# /*****************************************************************************/
#  * File: run_ripple_adder_tests.sh
#  * Author: Generated based on app.py by AI Assistant
#  * Date: 2025-02-04
#  * Description: Automated testing script for Ripple Adder implementations
# /*****************************************************************************/

# Color codes for enhanced terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration Variables
BASE_PATH="results"
PYTHON_SCRIPT="app.py"
MIN_BITS=8
MAX_BITS=32
STEP_BITS=2

# Threads and Block Configuration
THREADS_PER_BLOCK_OPTIONS=256
BLOCKS_PER_GRID_OPTIONS=768

# Logging and Result Tracking
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="${BASE_PATH}/test_results_${TIMESTAMP}.log"

# Function to print colored output
print_status() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${NC}"
}

# Function to run tests for a specific configuration
run_test() {
    local n_bits=$1
    local threads_per_block=$2
    local blocks_per_grid=$3
    local name="somador_n${n_bits}"
    local path="${BASE_PATH}/${name}"

    print_status "$YELLOW" "Running Test: N=${n_bits}, Threads=${threads_per_block}, Blocks=${blocks_per_grid}"
    
    # Redirect all output to log file and console
    {

        # Clean previous results if exist
        rm -rf "${path}"

        # Run Python script with parameters
        python3 "${PYTHON_SCRIPT}" \
            --n-bits "${n_bits}" \
            --threads-per-block "${threads_per_block}" \
            --blocks-per-grid "${blocks_per_grid}"

        # Capture exit status
        EXIT_STATUS=$?

        if [ ${EXIT_STATUS} -eq 0 ]; then
            print_status "$GREEN" "✓ Test Successful for N=${n_bits}"
        else
            print_status "$RED" "✗ Test Failed for N=${n_bits}"
        fi
    } 2>&1 | tee -a "${LOG_FILE}"
}

# Main testing function
run_comprehensive_tests() {
    print_status "$YELLOW" "Starting Comprehensive Ripple Adder Tests"
    
    # Create base results directory if not exists
    mkdir -p "${BASE_PATH}"

    # Nested loops for comprehensive testing
    for ((n_bits=MIN_BITS; n_bits<=MAX_BITS; n_bits+=STEP_BITS)); do
                run_test "${n_bits}" "${THREADS_PER_BLOCK_OPTIONS}" "${BLOCKS_PER_GRID_OPTIONS}" 
    done

    print_status "$GREEN" "Comprehensive Testing Complete. Check ${LOG_FILE} for detailed results."
}

# Argument parsing for manual configuration
while [[ $# -gt 0 ]]; do
    case $1 in
        --min-bits)
            MIN_BITS="$2"
            shift 2
            ;;
        --max-bits)
            MAX_BITS="$2"
            shift 2
            ;;
        --step-bits)
            STEP_BITS="$2"
            shift 2
            ;;
        --threads)
            THREADS_PER_BLOCK_OPTIONS=($2)
            shift 2
            ;;
        --blocks)
            BLOCKS_PER_GRID_OPTIONS=($2)
            shift 2
            ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
done

# Execute comprehensive tests
run_comprehensive_tests

# Optional: Generate a summary report
python3 generate_test_summary.py "${LOG_FILE}"
