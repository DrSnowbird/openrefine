FROM openkbs/jdk-mvn-py3

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

################################
#### ---- Environment Vars ----
################################

ARG OPENREFINE_VER=${OPENREFINE_VER:-2.7}
ARG OPENREFINE_PORT=${OPENREFINE_PORT:-3333}
ARG DATA_DIR=${DATA_DIR:-/data}
ARG OPENREFINE_VM_MAX_MEM=${OPENREFINE_VM_MAX_MEM:-16384M}

ENV OPENREFINE_VER=${OPENREFINE_VER}
ENV OPENREFINE_PORT=${OPENREFINE_PORT}
ENV DATA_DIR=${DATA_DIR}
ENV OPENREFINE_VM_MAX_MEM=${OPENREFINE_VM_MAX_MEM:-16384M}

ENV SERVERS_HOME=/usr

################################
#### ---- Openrefine Server ----
################################

## -- ref: https://github.com/OpenRefine/OpenRefine/releases/
## https://github.com/OpenRefine/OpenRefine/releases/download/2.7/openrefine-linux-2.7.tar.gz
ENV OPENREFINE_URL https://github.com/OpenRefine/OpenRefine/releases/download/${OPENREFINE_VER}/openrefine-linux-${OPENREFINE_VER}.tar.gz
ENV NER_EXTENSION_URL http://software.freeyourmetadata.org/ner-extension/ner-extension.zip

ENV OPENREFINE_DIR ${SERVERS_HOME}/openrefine
ENV OPENREFINE_HOME ${SERVERS_HOME}/openrefine/default

ENV PATH $PATH:${OPENREFINE_HOME}

RUN set -x \
    && mkdir -p ${OPENREFINE_DIR} \
    && ls -al ${SERVERS_HOME}
    
WORKDIR ${OPENREFINE_DIR}

## -- (opt-1.) Copy from local directory: --
#COPY ./openrefine-linux-${OPENREFINE_VER}.tar.gz ${OPENREFINE_DIR}/
#RUN set -x && \
#    tar xvf ${OPENREFINE_DIR}/$(basename ${OPENREFINE_DIR}) -C ${OPENREFINE_DIR}/ && \
#    ln -s ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER} ${OPENREFINE_HOME} && \
#    ls -al ${OPENREFINE_HOME} 
    
## -- (opt-2.) Download from Internet: --
RUN set -x &&\
    wget -c ${OPENREFINE_URL} && \
    tar xvf ${OPENREFINE_DIR}/$(basename ${OPENREFINE_URL}) -C ${OPENREFINE_DIR}/ && \
    ln -s ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER} ${OPENREFINE_HOME} && \
    ls -al ${OPENREFINE_HOME} 
    
RUN rm -f $(basename ${OPENREFINE_DIR})

################################
#### ---- Openrefine Extension ----
################################
#### /usr/openrefine/openrefine-2.7-rc.2/webapp/extensions
RUN set -x &&\
    wget -c ${NER_EXTENSION_URL} && \
    unzip  $(basename ${NER_EXTENSION_URL}) && \
    mv named-entity-recognition ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER}/webapp/extensions && \
    rm -f ner-extension.zip

################################
#### ---- Volume & Port  ----
################################
VOLUME ${DATA_DIR}

EXPOSE ${OPENREFINE_PORT}

################################
#### ---- Entrypoint ----
################################

WORKDIR ${DATA_DIR}

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ${OPENREFINE_HOME}/refine -i 0.0.0.0 -m ${OPENREFINE_VM_MAX_MEM}


