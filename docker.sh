#!/bin/bash
image_id='1104437281'
image_pwd='hst7562336'
docker login -u ${image_id} --password ${image_pwd}
IMAGE="image"
for sys in alpine arch bash debian devc fedora gentoo opensuse ubuntu centos ; do 
    for FIlE in $(ls ./src/$sys); do
        echo ./src/$sys/$FIlE
    done 
done
# docker build -t ${image_name} .
# docker run ${image_name}
# docker image tag ${image_name} ${image_id}/${image_name}
# docker image push ${image_id}/${image_name}
docker buildx create --use
docker buildx build \
        --no-cache \
        --platform "${PLATFORM:-linux/arm,linux/arm64,linux/amd64}" \
        -f "$FILE" \
        -t "$image_id/$IMAGE" . --push