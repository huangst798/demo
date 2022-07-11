#!/bin/bash
image_id='1104437281'
image_pwd='hst7562336'
docker login -u ${image_id} --password ${image_pwd}
for IMAGE in bash; do 
        for file in $(ls ./src/$IMAGE); do   
         FILE=$( echo ./src/$IMAGE/$file )   
        echo $FIlE
        docker buildx create --use
        docker buildx build \
        --no-cache \
        --platform "${PLATFORM:-linux/amd64}" \
        -f "$FILE" \
        -t "$image_id/$IMAGE" . --push
    done 
done