FROM --platform=$TARGETPLATFORM ubuntu:bionic

RUN apt update && apt install --assume-yes curl && apt clean
