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

from src.lut2graph import Graph
from src.lut2graph import CudaGenerator

def main():
    blif_path = "results/blif_generator/somador.blif"
    verilog_path = "results/blif_generator/somador.v"
    
    G = Graph(blif_path, verilog_path, debug=False).graph

    # Draw the graph
    pos = nx.kamada_kawai_layout(G)
    nx.draw(G, pos, with_labels=True)
    if not os.path.exists("results/graphs"):
        os.makedirs("results/graphs")
    plt.savefig("results/graphs/somador.png")

    # Generate the CUDA code
    cuda_gen = CudaGenerator(G)
    cuda_gen.run("results/cuda/somador.cu", profile=False)


if __name__ == "__main__":
    main()