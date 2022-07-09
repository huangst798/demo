FROM --platform=$TARGETPLATFORM debian:latest

RUN apt update && apt install --assume-yes curl && apt clean

