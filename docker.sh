#!/bin/bash
image_id='1104437281'
image_pwd='hst7562336'
docker login -u ${image_id} --password ${image_pwd}
for IMAGE in ubuntu; do 
    for FIlE in $(ls ./src/$IMAGE); do
        echo ./src/$IMAGE/$FIlE
        docker buildx create --use
        docker buildx build \
        --no-cache \
        --platform "${PLATFORM:-linux/arm,linux/arm64,linux/amd64}" \
        -f "./src/$IMAGE/$FILE" \
        -t "$image_id/$IMAGE" . --push
    done 
done