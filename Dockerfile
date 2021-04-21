FROM debian:buster

# Add piwheels support (pre-compiled binary Python packages for RPi)
COPY files/pip.conf /etc

# Source code path to clone to if CLONE=1
VOLUME /src

# Artifacts path to build if BUILD=1
VOLUME /build

# Install pre-requisites
COPY  scripts/setup/install-prereqs.sh /.install-prereqs
RUN /.install-prereqs

# Copy scripts used for main build
COPY scripts/build/clone-onnxruntime.sh /clone-onnxruntime
COPY scripts/build/build-onnxruntime.sh /build-onnxruntime
COPY scripts/build/entrypoint.sh /entrypoint
ENTRYPOINT ["/entrypoint"]

#########################
# Environment variables #
#########################
# Add extra printing
ENV DEBUG=1

# Disable build stages by overriding these environment variables to 0
ENV CLONE=1
ENV BUILD=1

# ~ Debian
ENV DEBIAN_FRONTEND=noninteractive

##############
# TEST BUILD #
##############
# This should be removed once the build passes
RUN mkdir -p /src
RUN /entrypoint
