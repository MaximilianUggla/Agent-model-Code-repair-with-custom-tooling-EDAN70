
FROM ubuntu:24.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install useful development tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        openjdk-11-jdk \
        maven \
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

# --- JUnit jars, downloaded at build time (needs internet here, not at runtime) ---
ENV JUNIT_DIR=/opt/junit
RUN mkdir -p $JUNIT_DIR && cd $JUNIT_DIR && \
    curl -fLO https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.2/junit-platform-console-standalone-1.10.2.jar && \
    curl -fLO https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar && \
    curl -fLO https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar && \
    mv junit-platform-console-standalone-1.10.2.jar junit-console.jar

# --- Wrapper script: compile all .java files and run all tests, offline ---
COPY public/run-tests.sh /usr/local/bin/run-tests
RUN chmod +x /usr/local/bin/run-tests

# --- Project files ---
WORKDIR /workspace
COPY javaTestFiles /workspace

# --- Maven only: pre-download dependencies and plugins so `mvn -o` works offline ---
# Skipped automatically if there is no pom.xml. Shared repo path avoids per-user cache issues.
ENV MAVEN_OPTS="-Dmaven.repo.local=/opt/m2"
RUN if [ -f pom.xml ]; then \
        mvn -q -Dmaven.repo.local=/opt/m2 dependency:go-offline && \
        mvn -q -Dmaven.repo.local=/opt/m2 test-compile; \
    fi && \
    mkdir -p /opt/m2 && chmod -R a+rwX /opt/m2

# Default shell
CMD ["/bin/bash"]]

