FROM --platform=$TARGETPLATFORM debian:bullseye

RUN apt update && apt install --assume-yes curl && apt clean
