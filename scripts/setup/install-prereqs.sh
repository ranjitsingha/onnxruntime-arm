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

# git workaround: https://superuser.com/questions/1642858/git-throws-fatal-unable-to-access-https-github-com-user-repo-git-failed-se
apt-get install -y libcurl3-gnutls=7.64.0-4+deb10u2

# Install latest versions
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install numpy
