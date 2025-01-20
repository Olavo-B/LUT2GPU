# LUT2GPU

This project aim to get a LUT graph and convert it to cuda code to be executed on GPU.
With this, we can get a fast LUT evaluation, compared to Icarus Verilog simulation.
The final goal is to use this LUT to pruning a neural network LUT graph using machine learning 
and heuristic algorithms.


## How to install

To install the project, run the following command in the ssh environment:

```bash
cd LUT2GPU
./install.sh
```

The script will set the permissions of the `run.sh` script to allow execution. And will install de docker image with the necessary dependencies.

## How to use

To run the project, run the following command in the ssh environment:

```bash
cd LUT2GPU
./run.sh
```

To access the jupyter notebook, open a web browser and go to the **address shown in the terminal**.

To stop the project, press `Ctrl+C` in the terminal.


## Folder structure

- misc: Miscellaneous files. Like docs, papers, etc.
- src: Source code of the project.
- tests: Test files for the project.
- notebooks: Jupyter notebooks for the project.
- scripts: Scripts for the project, like ABC and yosys scripts.

## Acknowledgements

## TODO


