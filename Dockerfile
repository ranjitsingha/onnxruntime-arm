FROM pitop/onnxruntime-builder:latest

RUN [ "cross-build-start" ]

# Install python3.7
RUN install_packages \
	build-essential \
	zlib1g-dev \
	libncurses5-dev \
	libgdbm-dev \
	libnss3-dev \
	libssl-dev \
	libreadline-dev \
	libffi-dev \
	wget

RUN cd /tmp \
	&& curl -O https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz \
	&& tar -xf Python-3.7.3.tar.xz \
	&& cd Python-3.7.3 \
	&& ./configure --enable-optimizations \
	&& make -j$(nproc) \
	&& make altinstall

RUN python3.7 --version


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
WORKDIR /onnxruntime
RUN ./build.sh \
    --use_openmp \
    --config MinSizeRel \
    # 32-bit ARM - currently only supported via cross-compiling; not compatible with NuGet
    --arm \
    --update --build --build_shared_lib --build_wheel \
    --parallel

RUN [ "cross-build-end" ]
