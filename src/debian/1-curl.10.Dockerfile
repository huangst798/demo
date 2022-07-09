FROM --platform=$TARGETPLATFORM debian:buster

RUN apt update && apt install --assume-yes curl && apt clean
