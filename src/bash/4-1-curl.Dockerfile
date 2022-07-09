FROM --platform=$TARGETPLATFORM bash:4

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*