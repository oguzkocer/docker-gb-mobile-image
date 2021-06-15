# syntax=docker/dockerfile:1
FROM debian:stable-slim

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update \
    && apt-get install -y curl git \
    && apt-get -y autoclean

SHELL ["/bin/bash", "--login", "-c"]

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN nvm install lts/*

RUN git clone https://github.com/wordpress-mobile/gutenberg-mobile.git /var/gutenberg-mobile --depth 1 \
    && pushd /var/gutenberg-mobile \
    && git submodule update --init --recursive  \
    && npm ci --no-audit --no-progress --unsafe-perm \
    && popd \
    && rm -rf /var/gutenberg-mobile

