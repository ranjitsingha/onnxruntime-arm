FROM debian:testing

# Source code path to clone to if CLONE=1
VOLUME /src
# Artifacts path to build if BUILD=1
VOLUME /build

COPY scripts/install-prereqs.sh /install-prereqs
RUN /install-prereqs

COPY scripts/build/clone.sh /clone
COPY scripts/build/build.sh /build
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

# Install pre-requisites
COPY  scripts/setup/install-prereqs.sh /.install-prereqs
RUN /.install-prereqs
