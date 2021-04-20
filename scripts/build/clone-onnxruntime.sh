#!/bin/bash
###############################################################
#                Unofficial 'Bash strict mode'                #
# http://redsymbol.net/articles/unofficial-bash-strict-mode/  #
###############################################################
set -euo pipefail
IFS=$'\n\t'
###############################################################

cd /src

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                             # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                     # Pluck JSON value
}

ONNXRUNTIME_REPO_ID="Microsoft/onnxruntime"
latest_release="$(get_latest_release ${ONNXRUNTIME_REPO_ID})"

git clone --depth 1 --single-branch --branch "${latest_release}" --recursive "https://github.com/${ONNXRUNTIME_REPO_ID}" onnxruntime
