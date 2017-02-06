#!/bin/sh
set -e
export CONTAINER=$(docker ps | grep POD | grep ${HOSTNAME} | cut -d' ' -f1 | grep .)
docker run --rm --net host --pid=host --privileged=true --entrypoint /bin/sh -v /var/run/docker.sock:/var/run/docker.sock $WEAVE_IMAGE /home/weave/weave --local attach $IP_TO_ATTACH $CONTAINER
