#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

TMP_DIR="$(mktemp -d)"

cd "${TMP_DIR}"

apt-get update

apt-get install -y \
    build-essential \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    wget \
    python3 \
    python3-pip \
    python3-dev \
    git \
    tar \
    libatlas-base-dev \
    protobuf-compiler
# libopenblas-dev
# mono-complete
# mono-devel

# git workaround: https://superuser.com/questions/1642858/git-throws-fatal-unable-to-access-https-github-com-user-repo-git-failed-se
apt-get install -y --allow-downgrades libcurl3-gnutls=7.64.0-4+deb10u2

# Newer cmake than is available in backports is required
wget https://github.com/Kitware/CMake/releases/download/v3.18.3/cmake-3.18.3.tar.gz
tar zxf cmake-3.18.3.tar.gz

cd cmake-3.18.3
./configure --system-curl
make -j$(nproc)
make install

# Install latest versions
python3 -m pip install --upgrade pip setuptools wheel numpy flake8

cd /
rm -rf "${TMP_DIR}"

# Delete cached files we don't need anymore
apt-get clean
rm -rf /var/lib/apt/lists/*
