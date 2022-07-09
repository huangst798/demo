FROM --platform=$TARGETPLATFORM ubuntu:jammy

RUN apt update && apt install --assume-yes curl && apt clean
