FROM openkbs/jre-mvn-py3

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

ENV SERVERS_HOME=/usr

ENV DATA_DIR /data
VOLUME $DATA_DIR

ENV OPENREFINE_VER=2.7-rc.2

################################
#### ---- Openrefine Server ----
################################

## -- ref: https://github.com/OpenRefine/OpenRefine/releases/
ENV OPENREFINE_URL https://github.com/OpenRefine/OpenRefine/releases/download/$OPENREFINE_VER/openrefine-linux-$OPENREFINE_VER.tar.gz
ENV NER_EXTENSION_URL http://software.freeyourmetadata.org/ner-extension/ner-extension.zip

ENV OPENREFINE_DIR $SERVERS_HOME/openrefine
ENV OPENREFINE_HOME $SERVERS_HOME/openrefine/default

ENV PATH $PATH:$OPENREFINE_HOME

RUN set -x \
    && mkdir -p $OPENREFINE_DIR \
    && ls -al $SERVERS_HOME
    
EXPOSE 3333

WORKDIR $OPENREFINE_DIR

## -- (opt-1.) Copy from local directory: --
#COPY ./openrefine-linux-$OPENREFINE_VER.tar.gz $OPENREFINE_DIR/
#RUN set -x && \
#    tar xvf $OPENREFINE_DIR/$(basename $OPENREFINE_URL) -C $OPENREFINE_DIR/ && \
#    ln -s $OPENREFINE_DIR/openrefine-$OPENREFINE_VER $OPENREFINE_HOME && \
#    ls -al $OPENREFINE_HOME 

#### /usr/openrefine/openrefine-2.7-rc.2/webapp/extensions
## -- (opt-2.) Download from Internet: --
RUN set -x &&\
    wget -c $OPENREFINE_URL && \
    tar xvf $OPENREFINE_DIR/$(basename $OPENREFINE_URL) -C $OPENREFINE_DIR/ && \
    ln -s $OPENREFINE_DIR/openrefine-$OPENREFINE_VER $OPENREFINE_HOME && \
    ls -al $OPENREFINE_HOME 
    
RUN rm -f $(basename $OPENREFINE_URL)

################################
#### ---- Openrefine Extension ----
################################
RUN set -x &&\
    wget -c ${NER_EXTENSION_URL} && \
    unzip  ner-extension.zip && \
    mv named-entity-recognition $OPENREFINE_DIR/openrefine-$OPENREFINE_VER/webapp/extensions && \
    rm -f ner-extension.zip

################################
#### ---- Entrypoint ----
################################

WORKDIR $DATA_DIR

CMD $OPENREFINE_HOME/refine -i 0.0.0.0 -m 4096m



