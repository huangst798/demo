#!/bin/bash
image_name='myhello:6.0'
image_id='1104437281'
docker build -t ${image_name} .
docker run ${image_name}
docker image tag ${image_name} ${image_id}/${image_name}
docker image push ${image_id}/${image_name}