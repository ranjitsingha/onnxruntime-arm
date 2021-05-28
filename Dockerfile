FROM pitop/onnxruntime-builder:latest

ARG ONNXRUNTIME_REPO=https://github.com/Microsoft/onnxruntime
ARG ONNXRUNTIME_VERSION=v1.7.2

# Enforces cross-compilation through Qemu.
RUN [ "cross-build-start" ]

# Set up build args
ARG BUILDTYPE=MinSizeRel
ARG BUILDARGS="--config ${BUILDTYPE} --arm"

# Prepare onnxruntime Repo
WORKDIR /code
RUN git clone --depth=1 --single-branch --branch ${ONNXRUNTIME_VERSION} --recursive ${ONNXRUNTIME_REPO} onnxruntime
WORKDIR /code/onnxruntime

# Patch numpy dependency version to match Buster
RUN sed -i "s/numpy==1.16.6/numpy==1.16.2/1" ./tools/ci_build/github/linux/docker/scripts/requirements.txt
RUN sed -i "s/numpy==1.16.6/numpy==1.16.2/1" ./tools/ci_build/github/linux/docker/scripts/training/requirements.txt
RUN sed -i "s/numpy==1.16.6/numpy==1.16.2/1" ./tools/ci_build/github/linux/docker/scripts/manylinux/requirements.txt
RUN sed -i "s/numpy>=1.16.6/numpy==1.16.2/1" ./tools/ci_build/build.py
RUN sed -i "s/numpy >= 1.16.6/numpy == 1.16.2/1" ./requirements.txt
RUN sed -i "s/numpy >= 1.16.6/numpy == 1.16.2/1" ./requirements-training.txt

# Fix build errors by using latest tag in json dir
RUN cd ./cmake/external/json && git checkout v3.9.1

# Build ORT including the shared lib and python bindings
RUN ./build.sh ${BUILDARGS} \
    --skip_submodule_sync --parallel --update \
    --build \
    --build_shared_lib \
    --enable_pybind \
    --build_wheel

# Show build output
RUN ls -l /code/onnxruntime/build/Linux/${BUILDTYPE}/*.so
RUN ls -l /code/onnxruntime/build/Linux/${BUILDTYPE}/dist/*.whl

RUN [ "cross-build-end" ]
