FROM openkbs/jre-mvn-py

MAINTAINER OpenKBS 

ENV SERVERS_HOME=/usr

ENV DATA_DIR /data
VOLUME $DATA_DIR

ENV OPENREFINE_VER=2.7-rc.2

################################
#### ---- Openrefine Server ----
################################

## -- ref: https://github.com/OpenRefine/OpenRefine/releases/
ENV OPENREFINE_URL https://github.com/OpenRefine/OpenRefine/releases/download/2.6-rc.2/openrefine-linux-2.6-rc.2.tar.gz
ENV OPENREFINE_URL https://github.com/OpenRefine/OpenRefine/releases/download/$OPENREFINE_VER/openrefine-linux-$OPENREFINE_VER.tar.gz

ENV OPENREFINE_DIR $SERVERS_HOME/openrefine
ENV OPENREFINE_HOME $SERVERS_HOME/openrefine/default

ENV PATH $PATH:$OPENREFINE_HOME

RUN set -x \
    && mkdir -p $OPENREFINE_DIR \
    && ls -al $SERVERS_HOME
    
EXPOSE 3333

WORKDIR $OPENREFINE_DIR

## -- (opt-1.) Copy from local directory: --
#COPY ./openrefine-linux-2.6-rc.2.tar.gz $OPENREFINE_DIR/
#COPY ./openrefine-linux-$OPENREFINE_VER.tar.gz $OPENREFINE_DIR/

#RUN set -x && \
#    tar xvf $OPENREFINE_DIR/$(basename $OPENREFINE_URL) -C $OPENREFINE_DIR/ && \
#    ln -s $OPENREFINE_DIR/openrefine-$OPENREFINE_VER $OPENREFINE_HOME && \
#    ls -al $OPENREFINE_HOME 
    
## -- (opt-2.) Download from Internet: --
RUN set -x &&\
    wget -c $OPENREFINE_URL && \
    tar xvf $OPENREFINE_DIR/$(basename $OPENREFINE_URL) -C $OPENREFINE_DIR/ && \
    ln -s $OPENREFINE_DIR/openrefine-$OPENREFINE_VER $OPENREFINE_HOME && \
    ls -al $OPENREFINE_HOME 
    
RUN rm -f $(basename $OPENREFINE_URL)

################################
#### ---- Entrypoint ----
################################

WORKDIR $DATA_DIR

CMD $OPENREFINE_HOME/refine -i 0.0.0.0



