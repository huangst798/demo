
FROM --platform=$TARGETPLATFORM xcmd/base-ubuntu-1-curl:20

RUN apt update && apt install --assume-yes bash zsh ksh git openssh-client && apt clean
