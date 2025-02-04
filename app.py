# /*****************************************************************************/
#  * File: app.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-01-27
#  * License: [License Type]
#  * Description: Main code of the application with CLI support
# /*****************************************************************************/

import networkx as nx
import matplotlib.pyplot as plt
from itertools import product
import os
import argparse

from src.ultils.sumConstructor import RippleAdderGenerator
from src.ultils.runScripts import RunScripts
from src.runMethods import RunMethods

def parse_arguments():
    """
    Parse command-line arguments for flexible testing configuration
    """
    parser = argparse.ArgumentParser(
        description='Ripple Adder Performance Testing Tool',
        epilog='Example: python app.py --n-bits 16 --threads-per-block 256 --blocks-per-grid 65536'
    )
    
    # Mandatory Arguments
    parser.add_argument(
        '--n-bits', 
        type=int, 
        default=14,
        help='Number of bits for the ripple adder (default: 14)'
    )
    
    # CUDA Configuration Arguments
    parser.add_argument(
        '--threads-per-block', 
        type=int, 
        default=256,
        help='Number of CUDA threads per block (default: 256)'
    )
    
    parser.add_argument(
        '--blocks-per-grid', 
        type=int, 
        default=768,
        help='Number of CUDA blocks per grid (default: 768)'
    )
    
    # Optional Debugging and Logging Arguments
    parser.add_argument(
        '--debug', 
        action='store_true',
        help='Enable debug mode with verbose output'
    )
    
    parser.add_argument(
        '--num-runs', 
        type=int, 
        default=3,
        help='Number of test runs (default: 3)'
    )
    
    parser.add_argument(
        '--output-path', 
        type=str, 
        default='results',
        help='Base path for storing test results (default: results)'
    )
    
    return parser.parse_args()

def main():
    # Parse command-line arguments
    args = parse_arguments()
    
    # Configure paths based on arguments
    NAME = f"somador_n{args.n_bits}"
    PATH = os.path.join(args.output_path, NAME)

    # Ensure output directories exist
    os.makedirs(os.path.join(PATH, 'verilog'), exist_ok=True)
    os.makedirs(os.path.join(PATH, 'cuda'), exist_ok=True)

    try:
        # Generate the sum
        adder = RippleAdderGenerator(
            n_bits=args.n_bits, 
            debug=args.debug
        )
        adder.save_files(os.path.join(PATH, 'verilog'))

        # Run the scripts
        script = RunScripts(
            path=PATH, 
            verilog_path=f"ripple_adder_{args.n_bits}bit.v", 
            top_module=f'ripple_adder_{args.n_bits}bit',
            args={'otimizations': ["resyn3", 'resyn'], 'lut_k': 5},
            debug=args.debug
        )
        script.run()

        # Run the methods
        runner = RunMethods(
            name=NAME, 
            blif_path=os.path.join(PATH, 'somador.blif'), 
            verilog_path=os.path.join(PATH, 'verilog', 'somador.v'), 
            debug=args.debug
        )
        runner.run_cuda(
            cuda_path=os.path.join(PATH, 'cuda'), 
            blocks_per_grid=args.blocks_per_grid, 
            threads_per_block=args.threads_per_block, 
            num_runs=args.num_runs,
        )
        runner.run_verilator(
            verilator_path=os.path.join(PATH, 'verilator'),
            num_runs=args.num_runs,
        )
        runner.analyze_results()

    except Exception as e:
        if args.debug:
            import traceback
            traceback.print_exc()
        print(f"Error during execution: {e}")
        raise

if __name__ == "__main__":
    main()