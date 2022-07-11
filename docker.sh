#!/bin/bash
image_id='1104437281'
image_pwd='hst7562336'
docker login -u ${image_id} --password ${image_pwd}
for sys in alpine; do 
        for file in $(ls ./src/$sys); do   
        FILE=$( echo ./src/$sys/$file )
        IMAGE=$( echo $file)
        echo $FIlE
        docker buildx create --use
        docker buildx build \
        --no-cache \
        --platform "${PLATFORM:-linux/arm,linux/arm64,linux/amd64}" \
        -f "$FILE" \
        -t "$image_id/$IMAGE" . --push
    done 
done