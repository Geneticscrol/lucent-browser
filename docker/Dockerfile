# Lucent Browser - Docker Build Environment
# Build once, test anywhere without installing dependencies

FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    git \
    mercurial \
    curl \
    wget \
    nodejs \
    npm \
    rustc \
    cargo \
    clang \
    libclang-dev \
    libgtk-3-dev \
    libdbus-glib-1-dev \
    libpulse-dev \
    yasm \
    nasm \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /build

# Copy project files
COPY . /build/

# Download Firefox source (if not exists)
RUN if [ ! -d "firefox-source" ]; then \
    echo "Downloading Firefox ESR source..."; \
    wget -q https://archive.mozilla.org/pub/firefox/releases/115.6.0esr/source/firefox-115.6.0esr.source.tar.xz && \
    tar -xf firefox-115.6.0esr.source.tar.xz && \
    mv firefox-115.6.0esr firefox-source && \
    rm firefox-115.6.0esr.source.tar.xz; \
    fi

# Copy configuration
RUN cp configs/mozconfig firefox-source/mozconfig

# Bootstrap and build
WORKDIR /build/firefox-source
RUN ./mach bootstrap --application-choice=browser --no-interactive
RUN ./mach build

# Set up profile with customizations
WORKDIR /build
RUN python3 build-scripts/run.py

ENTRYPOINT ["/build/firefox-source/mach", "run"]
