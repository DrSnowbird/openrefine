# OpenRefine (v3.4) + OpenJDK Java 8 JDK + Maven 3.6 + Python 3.6/2.7 + pip 20 + node 15 + npm 7 + Gradle 6
[![](https://images.microbadger.com/badges/image/openkbs/openrefine.svg)](https://microbadger.com/images/openkbs/openrefine "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/openrefine.svg)](https://microbadger.com/images/openkbs/openrefine "Get your own version badge on microbadger.com")

# ** UPDATE **
Use OpenJDK from now on!!

# Components:
* OpenRefine 3.4 http://<server_ip:3333>/
* Ubuntu 18.04 LTS now (soon will use Ubuntu 20.04 as LTS Docker base image).
* See [openkbs/jdk-mvn-py3 README.md](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md)
* See [Base Container Image: openkbs/jdk-mvn-py3](https://github.com/DrSnowbird/jdk-mvn-py3)
* See [Base Components: OpenJDK, Python 3, PIP, Node/NPM, Gradle, Maven, etc.](https://github.com/DrSnowbird/jdk-mvn-py3#components)
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy, ..., etc.

# Run (recommended for easy-start)
```
./run.sh
```

It actually automatically executes the docker run command as
```
sudo docker run --rm -it --name=openrefine --restart=no -e USER_ID=1000 -e GROUP_ID=1000 -e OPENREFINE_VM_MAX_MEM=8192M -e OPENREFINE_VER=3.1 -v $HOME/data-docker/openrefine/data:/home/developer/data -v $HOME/data-docker/openrefine/workspace:/home/developer/workspace -p 3333:3333 openkbs/openrefine
```
Note the above command will create $HOME/data and $HOME/workspace automatically mapping onto the container's equivalent directories so that you can just easily use your HOST's directories above to edit projects and data.

# Or, manually enter command by yourself
```
mkdir ./data
docker run -d --name my-openrefine -v $PWD/data:/data -i -t openkbs/openrefine
```

# Base the image to build add-on applications

```Dockerfile
FROM openkbs/openrefine
```

# Default Build (locally)
```
./build.sh
```

# Base the image to build add-on applications

```Dockerfile
FROM openkbs/openrefine
```

# Build (build your own image tag)

Say, you will build the image "my/openrefine".

```bash
docker build -t my/openrefine .
```

To run your own image, say, with some-openrefine:

```bash
mkdir ./data
docker run -d --name some-openrefine -v $PWD/data:/data -i -t my/openrefine
```

To change the default Java Max Memory used by OpenRefine (useful for processing large dataset)
```
Just edit docker.env file with, for example, default to 8192M (8GB memory)
  
OPENREFINE_VM_MAX_MEM=8192M
```
# Shell into the Docker instance
```bash
docker exec -it some-openrefine /bin/bash
```
# Use openrefine (with your Web Browsers)
Web UI:
```http
  http://<ip_address>:3333/
```

# Releases information
* [See Releases Information](https://github.com/DrSnowbird/jdk-mvn-py3#releases-information)

