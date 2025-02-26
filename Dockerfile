# Use uma imagem base do Python
FROM nvcr.io/nvidia/cuda:12.6.3-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive 

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    clang \
    lld \
    bison \
    flex \
    libreadline-dev \
    gawk \
    tcl-dev \
    libffi-dev \
    make \
    graphviz \
    xdot \
    pkg-config \
    software-properties-common \
    libboost-system-dev \
    libboost-python-dev \
    libboost-filesystem-dev \
    openmpi-bin \
    openmpi-common \
    libopenmpi-dev \
    zlib1g-dev \
    verilator \
    iverilog && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for CUDA
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"




# Clone Yosys repository, initialize submodules, and compile
RUN git clone https://github.com/YosysHQ/yosys.git yosys && \
    cd yosys && \
    git submodule update --init && \
    make config-clang && \
    make -j$(nproc) && \
    make install

# Set working directory
WORKDIR /app

# Copy project content into the container
COPY . .

# Create a virtual environment with Python 3.12 and install dependencies
RUN python3.12 -m venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"
RUN pip install --upgrade pip
RUN pip install git+https://github.com/Olavo-B/LoadDataset
RUN pip install -r requirements.txt

# Install Jupyter Notebook inside the virtual environment
RUN pip install jupyter

# Expose the Jupyter Notebook port
EXPOSE 8888

# Set default command for the container
CMD ["bash"]

