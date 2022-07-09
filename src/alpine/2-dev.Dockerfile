FROM --platform=$TARGETPLATFORM xcmd/base-alpine-1-curl

RUN apk add -u dash bash zsh mksh git openssh-client && rm -rf /var/cache/apk/*
