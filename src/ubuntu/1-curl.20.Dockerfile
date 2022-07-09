FROM --platform=$TARGETPLATFORM ubuntu:focal

RUN apt update && apt install --assume-yes curl && apt clean
