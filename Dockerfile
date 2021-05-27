FROM pitop/onnxruntime-builder-buster:latest

RUN [ "cross-build-start" ]

# Prepare onnxruntime Repo
WORKDIR /

RUN git clone \
  --depth 1 \
  --single-branch \
  --branch $(curl --silent "https://api.github.com/repos/Microsoft/onnxruntime/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') \
  --recursive \
  "https://github.com/Microsoft/onnxruntime" \
  onnxruntime

# Build ORT including the shared lib and python bindings
# 32-bit ARM - currently only supported via cross-compiling; not compatible with NuGet
WORKDIR /onnxruntime
RUN ./build.sh \
    --config MinSizeRel \
    --arm \
    --use_openmp \
    --update \
    --build \
    --parallel

RUN ./build.sh \
    --config MinSizeRel \
    --arm \
    --build_shared_lib \
    --parallel

RUN ./build.sh \
    --config MinSizeRel \
    --arm \
    --enable_pybind \
    --build_wheel \
    --parallel

RUN [ "cross-build-end" ]
