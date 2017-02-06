#!/bin/sh
set -e

# get container id
echo "detecting containerid"
export CONTAINER=$(docker ps | grep POD | grep ${HOSTNAME} | cut -d' ' -f1 | grep .)
echo "detected containerid $CONTAINER"

# check ip is not used
echo "running ping to ip"
! ping -c 1 $(echo $IP_TO_ATTACH | cut -d'/' -f1)
if [ $? -eq 1 ]; then echo "ping returned. ip is in use. aborting attaching ip to container."; exit 1; fi

# attach ip
echo "attaching ip to container"
docker run --rm --net host --pid=host --privileged=true --entrypoint /bin/sh -v /var/run/docker.sock:/var/run/docker.sock $WEAVE_IMAGE /home/weave/weave --local attach $IP_TO_ATTACH $CONTAINER

echo "done"
