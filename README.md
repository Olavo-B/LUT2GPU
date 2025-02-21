# GO FAST

A project that converts LUT (Look-Up Table) graphs into CUDA code for GPU execution, enabling faster circuit evaluation compared to Icarus Verilog simulation. This project aims to optimize neural network LUT graphs using machine learning and heuristic algorithms.

## Prerequisites

- Docker
- NVIDIA Container Toolkit
- CUDA-capable GPU
- SSH access to development environment

## Installation

1. Clone the repository and navigate to project directory:
```bash
git clone <repository-url>
cd LUT2GPU
```

2. Run the installation script:
```bash
./install.sh
```

The script performs:
- Script permission configuration
- Docker image installation with dependencies
- CUDA environment setup

## Usage

### Starting the Environment

Launch the project environment:
```bash
./run.sh
```

This will:
- Initialize Docker container
- Set up project directories
- Start Jupyter server
- Display access URL in terminal

### Available Scripts

#### Verilog Batch Processing
```bash
./scripts/verilog-batch-runner.sh -d <input-directory> [options]
```
Options:
- `--cuda`: Run CUDA simulation
- `--iverilog`: Run Icarus Verilog simulation
- `--all`: Run all simulations
- `--timeout <seconds>`: Set execution timeout

#### Ripple Adder Testing
```bash
./scripts/ripple-adder-test-script.sh [options]
```
Options:
- `--min-bits`: Minimum bits for testing
- `--max-bits`: Maximum bits for testing
- `--threads`: Threads per block
- `--blocks`: Blocks per grid

## Project Structure

```
LUT2GPU/
├── misc/               # Documentation and resources
├── src/               # Source code
│   ├── utils/         # Utility scripts
│   ├── codegen/      # CUDA generation tools
│   ├── graph/        # LUT graph handlers
│   └── ml/          # ML components
├── tests/            # Test files
├── notebooks/        # Jupyter notebooks
└── scripts/          # Utility scripts
```

## Core Components

1. **CUDA Generator** (`src/graph/lut2graph.py`):
   - Optimized CUDA code generation
   - 64-bit data type support
   - Multi-point parallel processing

2. **Execution Scripts** (`src/utils/runScripts.py`):
   - Yosys/ABC workflow management
   - Template-based script generation
   - Verilog to BLIF conversion

## Testing

Run the test suite:
```bash
./run_tests.sh
```

## Troubleshooting

Common issues:
- CUDA not found: Verify NVIDIA driver installation
- Docker permission denied: Add user to docker group
- Jupyter connection failed: Check port availability

## License

MIT License - see LICENSE file

## TODO

- [ ] Add benchmark results
- [ ] Expand documentation
- [ ] Implement more optimization algorithms