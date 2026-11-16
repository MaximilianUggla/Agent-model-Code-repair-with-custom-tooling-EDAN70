
FROM ubuntu:24.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install useful development tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        openjdk-11-jdk \
        sudo \
        bash \
        curl \
        wget \
        git \
        nano \
        vim \
        build-essential \
        gcc \
        g++ \
        make \
        cmake \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev \
        ca-certificates \
        pkg-config \
        iputils-ping \
        net-tools \
        htop \
        tree \
        unzip \
        zip \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

COPY javaTestFiles /workspace

# Set working directory
WORKDIR /workspace

# Default shell
CMD ["/bin/bash"]

