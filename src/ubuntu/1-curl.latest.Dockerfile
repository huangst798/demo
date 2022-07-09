FROM --platform=$TARGETPLATFORM ubuntu:latest

RUN apt update && apt install --assume-yes curl && apt clean
