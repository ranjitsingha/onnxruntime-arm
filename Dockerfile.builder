# Adapted from https://github.com/microsoft/onnxruntime/blob/master/dockerfiles/Dockerfile.arm32v7
FROM balenalib/raspberrypi3-python:3.7-stretch

RUN install_packages \
    build-essential \
    curl \
    git \
    libatlas-base-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    locales \
    protobuf-compiler \
    sudo \
    tar \
    wget \
    zlib1g \
    zlib1g-dev

# Build cmake
WORKDIR /code
RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.3/cmake-3.18.3.tar.gz
RUN tar zxf cmake-3.18.3.tar.gz

WORKDIR /code/cmake-3.18.3
RUN ./configure --system-curl --parallel=$(nproc)
RUN make -j$(nproc)
RUN sudo make install

RUN install_packages \

# Uncomment en_US.UTF-8 for inclusion in generation
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen

# Generate locale
RUN locale-gen

# Export env vars (may not be necessary)
RUN echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc
RUN echo "export LANG=en_US.UTF-8" >> ~/.bashrc
RUN echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc

# Carefully install the latest version of pip
WORKDIR /pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade wheel

# Install Buster version of numpy (need to build it, sadly)
RUN pip3 install numpy==1.16.2

