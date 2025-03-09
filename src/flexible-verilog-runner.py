#!/usr/bin/env python3
# /*****************************************************************************/
#  * File: verilog_runner.py
#  * Author: Olavo Barros
#  * Date: 2025-02-04
#  * Description: Comprehensive Verilog simulation and performance testing tool
# /*****************************************************************************/

import os
import argparse
import sys

from ultils.runScripts import RunScripts
from ultils.runMethods import RunMethods
from ultils.style import Mensage

def validate_file(file_path):
    """Validate if the file exists and has a .v extension"""
    if not os.path.exists(file_path):
        raise argparse.ArgumentTypeError(f"File not found: {file_path}")
    if not file_path.lower().endswith('.v'):
        raise argparse.ArgumentTypeError(f"File must be a Verilog file (.v): {file_path}")
    return file_path

def main():
    # Argument Parser
    parser = argparse.ArgumentParser(
        description='Comprehensive Verilog Simulation and Performance Testing Tool',
        epilog='Example: python verilog_runner.py -v circuit.v -t <top_module name> --all'
    )

    # Required Arguments
    parser.add_argument('-v', '--verilog', 
                        type=str, 
                        required=True, 
                        help='Path to the input Verilog file')
    
    parser.add_argument('-t', '--top-module', '--top', 
                        type=str, 
                        required=True, 
                        help='Top-level module name in the Verilog file')

    # Simulation Type Selection
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--cuda', 
                       action='store_true', 
                       help='Run only CUDA simulation')
    group.add_argument('--iverilog',
                        action='store_true',
                        help='Run only Icarus Verilog simulation')
    group.add_argument('--cpu', 
                       action='store_true', 
                       help='Run only CPU simulation')
    group.add_argument('--verilator', 
                       action='store_true', 
                       help='Run only Verilator simulation')
    group.add_argument('--all', 
                       action='store_true', 
                       help='Run all simulations (CUDA, CPU, Verilator)')

    # Performance and Profiling Options
    parser.add_argument('--name', 
                        default='verilog_test', 
                        help='Name for the test run (default: verilog_test)')
    
    parser.add_argument('--num-runs', 
                        type=int, 
                        default=10, 
                        help='Number of performance test runs (default: 10)')
    
    parser.add_argument('--lut-size',
                        type=int,
                        default=5,
                        help='LUT size for the FPGA (default: 5)')
    
    parser.add_argument('--cuda-threads', 
                        type=int, 
                        default=256, 
                        help='CUDA threads per block (default: 256)')
    
    parser.add_argument('--cuda-blocks', 
                        type=int, 
                        default=768, 
                        help='CUDA blocks per grid (default: 768)')
    
    parser.add_argument('--probability',
                        type=int,
                        default=50,
                        help='Probability of pruning (default: 50)')
    
    parser.add_argument('--profile', 
                        action='store_true', 
                        help='Enable CUDA profiling')
    
    parser.add_argument('--debug', 
                        action='store_true', 
                        help='Enable debug output')
    
    parser.add_argument('--method', '-m', 
                        type=str, 
                        default='1_point', 
                        help='Method to run (default: 1_point)')
    
    parser.add_argument('--output', '-o',
                        type=str,
                        default='results',
                        help='Output directory for results (default is results)')

    # Parse arguments
    args = parser.parse_args()

    # Determine simulation modes
    run_modes = []
    if args.cuda or args.all:
        run_modes.append('cuda')
    if args.iverilog or args.all:
        run_modes.append('iverilog')
    if args.verilator or args.all:
        run_modes.append('verilator')
    if args.cpu or args.all:
        run_modes.append('cpu')

    # If no mode specified, default to all
    if not run_modes:
        run_modes = ['cuda', 'iverilog', 'verilator', 'cpp']
    
    # Ensure output directories exist
    PATH = f'results/{args.name}' if args.output == 'results' else os.path.join(args.output, args.name)
    os.makedirs(PATH, exist_ok=True)

    # Move verilog file to the correct path
    os.makedirs(os.path.join(PATH, 'verilog'), exist_ok=True)
    os.system(f"cp {args.verilog} {os.path.join(PATH, 'verilog')}")

    # Move .csv input file to the correct path
    os.makedirs(os.path.join(PATH, 'data'), exist_ok=True)
    # Get root folder of benchmark
    benchmark = os.path.dirname(args.verilog)
    for file in os.listdir(benchmark):
        if file.endswith(".csv"):
            input = os.path.join(benchmark, file)
            break
    os.system(f"cp {input} {os.path.join(PATH, 'cuda')}")



    mensage = Mensage()
    mensage.title()
    
    # Create RunScripts instance
    scripts = RunScripts(
        path=PATH,
        verilog_path=f'{os.path.basename(args.verilog)}', 
        top_module=args.top_module,
        args={'otimizations': ["resyn3", 'resyn'], 'lut_k': args.lut_size},
        debug=args.debug
    )
    scripts.run_yosys()


    # Create RunMethods instance
    runner = RunMethods(
        name=PATH, 
        blif_path=os.path.join(PATH, 'somador.blif'), 
        verilog_path=os.path.join(PATH, 'verilog', 'somador.v'), 
        debug=args.debug
    )

    # Execution block
    try:
        # Determine base paths for different simulation types
        base_path = PATH
        
        if 'cuda' in run_modes:
            print("\n🚀 Running CUDA Simulation:")
            runner.run_cuda(
                cuda_path=f'{base_path}/cuda', 
                threads_per_block=args.cuda_threads, 
                blocks_per_grid=args.cuda_blocks, 
                num_runs=args.num_runs,
                method=args.method,
                probability=args.probability, 
                profile=args.profile
            )
        
        # if 'iverilog' in run_modes:
        #     print("\n🧩 Running Icarus Verilog Simulation:")
        #     runner.run_iverilog(
        #         verilog_path=f'{base_path}/verilog', 
        #         exe_name='circuit', 
        #         num_runs=args.num_runs
        #     )

        if 'cpu' in run_modes:
            print("\n🧩 Running CPU Simulation:")
            runner.run_cpu(
                cpu_path=f'{base_path}/cpp', 
                num_runs=args.num_runs,
                method=args.method,
                probability=args.probability
            )
        
        if 'verilator' in run_modes:
            print("\n🔬 Running Verilator Simulation:")
            runner.run_verilator(
                verilator_path=f'{base_path}/verilator', 
                num_runs=args.num_runs
            )

        # Analyze overall results
        print("\n📊 Performance Analysis:")
        runner.analyze_results()

    except Exception as e:
        print(f"❌ Error during simulation: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
