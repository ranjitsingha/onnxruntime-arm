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

onnxruntime_repo_id="Microsoft/onnxruntime"

git clone \
  --depth 1 \
  --single-branch \
  --branch $(get_latest_release ${onnxruntime_repo_id}) \
  --recursive \
  git://github.com/${onnxruntime_repo_id}.git \
  onnxruntime
