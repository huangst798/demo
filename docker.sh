#!/bin/bash
image_name='myhello:6.0'
image_id='1104437281'
image_pwd='hst7562336'
FILE='src/arch/2-dev.Dockerfile'
IMAGE='2-dev'
docker login -u ${image_id} --password ${image_pwd}
# docker build -t ${image_name} .
# docker run ${image_name}
# docker image tag ${image_name} ${image_id}/${image_name}
# docker image push ${image_id}/${image_name}
docker buildx create --use
docker buildx build \
        --no-cache \
        --platform "${PLATFORM:-linux/arm,linux/arm64,linux/amd64}" \
        -f "$FILE" \
        -t "$IMAGE" . --push