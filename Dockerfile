FROM openkbs/jdk-mvn-py3

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

################################
#### ---- Environment Vars ----
################################

ARG OPENREFINE_VER=${OPENREFINE_VER:-3.4.1}
ARG OPENREFINE_PORT=${OPENREFINE_PORT:-3333}
ARG DATA_DIR=${DATA_DIR:-${USER}/data}
ARG OPENREFINE_VM_MAX_MEM=${OPENREFINE_VM_MAX_MEM:-4096M}

ENV OPENREFINE_VER=${OPENREFINE_VER}
ENV OPENREFINE_PORT=${OPENREFINE_PORT}
ENV DATA_DIR=${DATA_DIR}
ENV OPENREFINE_VM_MAX_MEM=${OPENREFINE_VM_MAX_MEM:-4096M}

ENV SERVERS_HOME=/usr

################################
#### ---- Openrefine Server ----
################################

## -- ref: https://github.com/OpenRefine/OpenRefine/releases/
## https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz
## https://github.com/OpenRefine/OpenRefine/releases/download/3.4.1/openrefine-linux-3.4.1.tar.gz
ENV OPENREFINE_URL https://github.com/OpenRefine/OpenRefine/releases/download/${OPENREFINE_VER}/openrefine-linux-${OPENREFINE_VER}.tar.gz
# https://software.freeyourmetadata.org/ner-extension/ner-extension.zip
ENV NER_EXTENSION_URL http://software.freeyourmetadata.org/ner-extension/ner-extension.zip

ENV OPENREFINE_DIR ${SERVERS_HOME}/openrefine
ENV OPENREFINE_HOME ${SERVERS_HOME}/openrefine/default

ENV PATH $PATH:${OPENREFINE_HOME}

user root

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
    wget -cq ${OPENREFINE_URL} && \
    tar xvf ${OPENREFINE_DIR}/$(basename ${OPENREFINE_URL}) -C ${OPENREFINE_DIR}/ && \
    ln -s ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER} ${OPENREFINE_HOME} && \
    ls -al ${OPENREFINE_HOME} 
    
#RUN rm -f $(basename ${OPENREFINE_DIR})

################################
#### ---- Openrefine Extension ----
################################
# (see: https://freeyourmetadata.org/named-entity-extraction/)
#### /usr/openrefine/openrefine-3.1/webapp/extensions
#RUN set -x && \
#    wget ${NER_EXTENSION_URL} && \
#    unzip  $(basename ${NER_EXTENSION_URL}) && \
#    mv named-entity-recognition ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER}/webapp/extensions && \
#    rm -f ner-extension.zip


#WORKDIR ${OPENREFINE_DIR}
#RUN echo "OPENREFINE_HOME=${OPENREFINE_HOME}" && \
#    ls -al ${OPENREFINE_HOME} && \
#    ls -al ${OPENREFINE_HOME}/webapp/WEB-INF/lib

RUN echo "OPENREFINE_HOME=${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER}/webapp/WEB-INF/lib" && \
    ls -al ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER}/webapp/WEB-INF/lib

#### ---- Patch in missing json.org jar file  ----
ADD lib /usr/openrefine/openrefine-3.4.1/webapp/WEB-INF/lib
RUN sudo chown ${USER}:${USER} ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER}/webapp/WEB-INF/lib/json*.jar && \
    echo " ===> OPENREFINE_HOME=${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER}/webapp/WEB-INF/lib" && \
    ls -al ${OPENREFINE_DIR}/openrefine-${OPENREFINE_VER}/webapp/WEB-INF/lib


################################
#### ---- Volume & Port  ----
################################
VOLUME ${DATA_DIR}

EXPOSE ${OPENREFINE_PORT}

################################
#### ---- Entrypoint ----
################################

USER ${USER}
WORKDIR ${DATA_DIR}

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ${OPENREFINE_HOME}/refine -i 0.0.0.0 -m ${OPENREFINE_VM_MAX_MEM}


