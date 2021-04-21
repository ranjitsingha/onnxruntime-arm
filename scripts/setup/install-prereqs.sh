#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

apt-get update

apt-get install -t buster-backports -y \
    build-essential \
    cmake \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    wget \
    python3 \
    python3-dev \
    python3-numpy \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    git \
    tar \
    libatlas-base-dev \
    libopenblas-dev \
    mono-complete \
    mono-devel

# Install latest versions
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install numpy
