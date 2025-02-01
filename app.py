# /*****************************************************************************/
#  * File: app.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-01-27
#  * License: [License Type]
#  * Description: Main code of the application.
# /*****************************************************************************/

import networkx as nx
import matplotlib.pyplot as plt
from itertools import product
import os


from src.runMethods import RunMethods

def main():
    blif_path = "results/blif_generator/somador.blif"
    verilog_path = "results/blif_generator/somador.v"
    
    runner = RunMethods(name="rato", blif_path=blif_path, 
                        verilog_path=verilog_path, debug=True)
    runner.run_all(blocks_per_grid=64, threads_per_block=1024, num_runs=3)
    runner.analyze_results()

if __name__ == "__main__":
    main()