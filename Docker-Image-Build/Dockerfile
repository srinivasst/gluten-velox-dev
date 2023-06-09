FROM ubuntu:22.04

# Set a default timezone, can be overriden via ARG
ARG tz="Europe/Madrid"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# TZ and DEBIAN_FRONTEND="noninteractive"
# are required to avoid tzdata installation
# to prompt for region selection.
ENV DEBIAN_FRONTEND="noninteractive" TZ=${tz}

#SET UP DEPENDENCIES

#GLUTEN
RUN \
    apt update && \
    apt install -y \
        build-essential \
        ccache \
        clang-11 \
        cmake \
        git \
        libboost-all-dev \
        libcurl4-openssl-dev \
        libdwarf-dev \
        libiberty-dev \
        libre2-dev \
        libssl-dev \
        libz-dev \
        llvm-11-dev \
        locales \
        maven \
        ninja-build \
        openjdk-8-jdk \
        tar \
        tzdata \
        wget

#IDEA AND CLION
RUN \
    apt update && \
    apt install -y \
        libcanberra-gtk3-module


#FIREFOX
RUN \
    apt-get update && \
    apt-get install -y firefox

#CLION
ARG CLION_VERSION=2023.1.2
ARG CLION_BUILD=2023.1.2
ARG clion_source=https://download.jetbrains.com/cpp/CLion-${CLION_BUILD}.tar.gz
ARG clion_local_dir=.CLion${CLION_BUILD}
WORKDIR /opt/clion
RUN \
    wget -O /opt/clion/installer.tgz $clion_source && \
    tar --strip-components=1 -xzf installer.tgz && \
    rm installer.tgz
RUN \
    mkdir /root/.CLion && \
    ln -sf /root/.CLion /root/$clion_local_dir

#INTELIJ
ARG IDEA_VERSION=2023.1.1
ARG IDEA_BUILD=2023.1.1
ARG idea_source=https://download.jetbrains.com/idea/ideaIC-${IDEA_BUILD}.tar.gz
ARG idea_local_dir=.IdeaIC${IDEA_VERSION}
WORKDIR /opt/idea
RUN \
    wget -O /opt/idea/installer.tgz $idea_source && \
    tar --strip-components=1 -xzf installer.tgz && \
    rm installer.tgz
RUN \
    mkdir /root/.Idea && \
    ln -sf /root/.Idea /root/$idea_local_dir

#MAVEN
WORKDIR /opt
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz
RUN tar xzf apache-maven-3.9.1-bin.tar.gz
RUN rm apache-maven-3.9.1-bin.tar.gz
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    M2_HOME=/opt/apache-maven-3.9.1
RUN update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.9.1/bin/mvn 900

#PROTOBUF
WORKDIR /opt
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v21.4/protobuf-all-21.4.tar.gz
RUN tar -xzf protobuf-all-21.4.tar.gz
RUN rm protobuf-all-21.4.tar.gz
WORKDIR /opt/protobuf-21.4
RUN ./configure CXXFLAGS="-fPIC" --prefix=/usr/local
RUN make "-j2"
RUN make install
RUN ldconfig

#VELOX
WORKDIR /root
RUN git clone https://github.com/oap-project/velox.git
WORKDIR /root/velox
RUN git submodule sync --recursive
RUN git submodule update --init --recursive
RUN sed -i 's/sudo --preserve-env //g' scripts/setup-ubuntu.sh
RUN sed -i 's/sudo//g' scripts/setup-ubuntu.sh
RUN sed -i 's/sudo//g' scripts/setup-helper-functions.sh
RUN scripts/setup-ubuntu.sh
RUN sed -i '/^NUM_THREADS/s/.*/NUM_THREADS ?= 2/' Makefile
RUN make debug EXTRA_CMAKE_FLAGS=" -DVELOX_ENABLE_PARQUET=ON -DVELOX_BUILD_TESTING=OFF -DVELOX_ENABLE_DUCKDB=OFF -DVELOX_BUILD_TEST_UTILS=ON -DCMAKE_BUILD_TYPE=debug"
WORKDIR /root/velox/_build/debug/_deps
RUN cmake --install xsimd-build/

#GLUTEN
WORKDIR /root
RUN git clone https://github.com/oap-project/gluten.git
WORKDIR /root/gluten/ep/build-arrow/src/
RUN ./get_arrow.sh
RUN ./build_arrow.sh
WORKDIR /root/gluten/cpp
RUN mkdir build
WORKDIR /root/gluten/cpp/build
RUN cmake -DBUILD_VELOX_BACKEND=ON -DVELOX_HOME=/root/velox -DCMAKE_BUILD_TYPE=Debug ..
RUN make
WORKDIR /root/gluten
RUN mvn clean package -Pbackends-velox -Pspark-3.3 -DskipTests

# Prevent container from exiting
CMD ["tail", "-f", "/dev/null"]