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

# --use_openblas
# --build_java
Compiling the Java API requires gradle v6.1+ to be installed in addition to the usual requirements.
Node.js –build_nodejs
./build.sh \
  --use_openmp \
  --update \
  --config ${BUILDTYPE} ${ARCH_ARGS} \
  --build_wheel \
  --build_nuget

mv build/* /build/
