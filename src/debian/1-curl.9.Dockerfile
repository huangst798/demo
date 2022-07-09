FROM --platform=$TARGETPLATFORM debian:stretch

RUN apt update && apt install --assume-yes curl && apt clean
