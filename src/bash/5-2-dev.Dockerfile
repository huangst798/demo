FROM --platform=$TARGETPLATFORM xcmd/base-bash5-1-curl

RUN apk add -u dash zsh mksh git openssh-client && rm -rf /var/cache/apk/*