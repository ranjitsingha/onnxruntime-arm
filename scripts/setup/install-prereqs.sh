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
    python3-pip \
    python3-setuptools \
    python3-wheel \
    git \
    tar \
    libatlas-base-dev \
    libopenblas-dev \
    mono-complete \
    mono-devel \
    zlib1g-dev

# Install latest versions
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install numpy

# Build the latest cmake
cd "$(mktemp -d)"
cmake_version="3.18.3"
cmake_filename="cmake-${cmake_version}"
wget "https://github.com/Kitware/CMake/releases/download/v${cmake_version}/${cmake_filename}.tar.gz"
tar zxf "${cmake_filename}.tar.gz"

cd "${cmake_filename}"
./configure --system-curl
make -j$(nproc)
make install
