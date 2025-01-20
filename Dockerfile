# Use uma imagem base do Python
FROM jupyter/base-notebook:x86_64-python-3.11.6


# Switch to root user before installing packages
USER root


# Update package list, install required dependencies, and clean apt cache
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
    python3 \
    libboost-system-dev \
    libboost-python-dev \
    libboost-filesystem-dev \
    zlib1g-dev \
    verilator \
    iverilog && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    

# Clone Yosys repository, initialize submodules, and configure for Clang or GCC
RUN git clone https://github.com/YosysHQ/yosys.git yosys && \
    cd yosys && \
    git submodule update --init && \
    make config-clang && \  
    make -j$(nproc) && \
    make install



# Set the working directory to /app
WORKDIR /app

# Copy the content of your project folder into the container
COPY . .

# Install the LoadDataset package from GitHub and the requirements
RUN pip install git+https://github.com/Olavo-B/LoadDataset

# Install the requirements
RUN pip install -r requirements.txt


# Set the default command to bash
CMD ["bash"]