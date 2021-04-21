#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

apt-get update

apt-get -t buster-backports install -y \
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
    cmake \
    protobuf-compiler
# libopenblas-dev
# mono-complete
# mono-devel

# git workaround: https://superuser.com/questions/1642858/git-throws-fatal-unable-to-access-https-github-com-user-repo-git-failed-se
apt-get install -y --allow-downgrades libcurl3-gnutls=7.64.0-4+deb10u2

# Install latest versions
python3 -m pip install --upgrade pip setuptools wheel numpy flake8
