#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

cd /src/onnxruntime

BUILDTYPE="MinSizeRel"

ARCH_ARGS=""
if [[ "$(uname -m)" == "armhf" ]]; then
  ARCH_ARGS="--arm"
elif [[ "$(uname -m)" == "arm64" ]]; then
  ARCH_ARGS="--arm64"
fi

# Docs
# https://www.onnxruntime.ai/docs/how-to/build.html

# Start the basic build
./build.sh --use_openmp --parallel --config ${BUILDTYPE} ${ARCH_ARGS} --update --build

# Build Shared Library
./build.sh --use_openmp --parallel --config ${BUILDTYPE} ${ARCH_ARGS} --build_shared_lib

# Build Python Bindings and Wheel
./build.sh --use_openmp --parallel --config ${BUILDTYPE} ${ARCH_ARGS} --enable_pybind --build_wheel

# Build NuGet package
./build.sh --use_openmp --parallel --config ${BUILDTYPE} ${ARCH_ARGS} --build_nuget

mv build/* /build/
