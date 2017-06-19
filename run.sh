#!/bin/bash -x

if [ $# -lt 1 ]; then
    echo "Usage: "
    echo "  ${0} [<repo-name/repo-tag>] "
    echo "e.g."
    echo "  ${0} openkbs/openrefine"
fi

## -- mostly, don't change this --
MY_IP=`ip route get 1|awk '{print$NF;exit;}'`

function displayPortainerURL() {
    port=${1}
    echo "... Go to: http://${MY_IP}:${port}"
    #firefox http://${MY_IP}:${port} &
    if [ "`which google-chrome`" != "" ]; then
        /usr/bin/google-chrome http://${MY_IP}:${port} &
    else
        firefox http://${MY_IP}:${port} &
    fi
}

##################################################
#### ---- Mandatory: Change those ----
##################################################
baseDataFolder=~/data-docker
imageTag=${1:-"openkbs/openrefine"}

PACKAGE=openrefine
GRAPHDB_HOME=/usr/${PACKAGE}

## -- Don't change this --
PACKAGE=`echo ${imageTag##*/}|tr "/\-: " "_"`

## -- Volume mapping --
docker_volume_data1=/data
local_docker_data1=${baseDataFolder}/${PACKAGE}/data

## -- local data folders on the host --
mkdir -p ${local_docker_data1}

#### ---- ports mapping ----
docker_port1=3333
local_docker_port1=3333

##################################################
#### ---- Mostly, you don't need change below ----
##################################################
## -- mostly, don't change this --

#instanceName=my-${2:-${imageTag%/*}}_$RANDOM
#instanceName=my-${2:-${imageTag##*/}}
instanceName=`echo ${imageTag}|tr "/\-: " "_"`

#### ----- RUN -------
# docker logs -f ${instanceName} &

echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"

set -x
docker run --rm \
    -d \
    --name=${instanceName} \
    -p ${local_docker_port1}:${docker_port1} \
    -v ${local_docker_data1}:${docker_volume_data1} \
    ${imageTag}
set +x

echo ">>> Docker Status"
docker ps -a | grep "${instanceName}"
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lqa`"
echo "docker exec -it ${instanceName} /bin/bash"

#### ---- Display IP:Port URL ----
displayPortainerURL ${local_docker_port1}

