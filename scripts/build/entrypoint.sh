#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

debug_echo() {
  if [[ "${DEBUG}" -eq 1 ]]; then
    echo "[Entrypoint] $1"
  fi
}

if [[ "${CLONE}" -eq 1 ]]; then
  debug_echo "'CLONE' set to 1 - installing build dependencies..."
  /clone-onnxruntime
else
  debug_echo "'CLONE' is not set to 1 - skipping build..."
fi

# ----

if [[ "${BUILD}" -eq 1 ]]; then
  debug_echo "'BUILD' set to 1 - building..."
  /build-onnxruntime
else
  debug_echo "'BUILD' is not set to 1 - skipping build..."
fi
