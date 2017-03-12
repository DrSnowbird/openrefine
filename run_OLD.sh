#!/bin/bash -x


# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/

echo "Usage: "
echo "  ${0} <repo-name/repo-tag>"
echo
imageTag=${1:-openkbs/openrefine}

#instanceName=my-${2:-${imageTag%/*}}_$RANDOM
instanceName=some-${2:-${imageTag##*/}}
portList="-p 3333:3333"
volume=data

mkdir -p ./${volume}

echo "(example)"
echo "docker run -d --name some-${imageTag##*/} -v /${volume}:/${volume} -i -t ${imageTag}"
#docker run -d --name ${instanceName} ${portList} -v $PWD/${volume}:/${volume} -i -t ${imageTag}
docker run -d --name ${instanceName} ${portList} -v $PWD/${volume}:/${volume} -t ${imageTag}

echo ">>> Docker Status"
docker ps -a
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lq`"
#docker exec -it ${instanceName} /bin/bash

