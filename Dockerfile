FROM ubuntu:20.04

# Install packages
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
    curl \
    file \
    git-all \  
    jq \
    lcov \
    libglu1-mesa \
    sudo \
    unzip \
    xz-utils \
    zip 

# Install nodejs 16.X
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq -y nodejs 
#  rm -rf /var/lib/apt/lists/*

# Flutter bits go into /flutterbuilder
RUN mkdir /flutterbuilder
WORKDIR /flutterbuilder

ARG FLUTTER_VERSION=2.8.1
RUN git clone --depth=1  https://github.com/flutter/flutter.git -b ${FLUTTER_VERSION}
RUN echo >> /root/.profile 'export PATH="$PATH:/flutterbuilder/flutter/bin:/flutterbuilder/flutter/bin/cache/dart-sdk/bin:/root/.pub-cache/bin"'
RUN bash -l -c 'flutter precache && flutter config --no-analytics'

ENTRYPOINT [ "/bin/bash", "-l", "-c", "--" ]
