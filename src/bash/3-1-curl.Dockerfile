FROM --platform=$TARGETPLATFORM bash:3

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*