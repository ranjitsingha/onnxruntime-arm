#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

apt update && apt install -y \
    build-essential \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    wget \
    python3 \
    python3-dev \
    git \
    tar \
    libatlas-base-dev \
    libopenblas-dev \
    mono-complete \
    mono-devel

# Carefully install the latest version of pip
cd /pip
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
pip3 install --upgrade setuptools
pip3 install --upgrade wheel
pip3 install numpy

# Build the latest cmake
cd /code
cmake_version="3.18.3"
cmake_filename="cmake-${cmake_version}"
wget "https://github.com/Kitware/CMake/releases/download/v${cmake_version}/${cmake_filename}.tar.gz"
tar zxf "${cmake_filename}.tar.gz"

cd "${cmake_filename}"
./configure --system-curl
make
make install
