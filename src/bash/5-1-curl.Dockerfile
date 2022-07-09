FROM --platform=$TARGETPLATFORM bash:5

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*