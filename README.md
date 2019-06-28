# OpenJDK Java 8 (1.8.0_212) JDK + Maven 3.6 + Python 3.6/2.7 + pip 19 + node 11 + npm 6 + Gradle 5.3
[![](https://images.microbadger.com/badges/image/openkbs/openrefine.svg)](https://microbadger.com/images/openkbs/openrefine "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/openrefine.svg)](https://microbadger.com/images/openkbs/openrefine "Get your own version badge on microbadger.com")

# ** UPDATE **
Use OpenJDK from now on!!

# Components:
* OpenRefine 3.1 http://<server_ip:3333>/
* openjdk version "1.8.0_212"
  OpenJDK Runtime Environment (build 1.8.0_212-8u212-b01-1~deb9u1-b01)
  OpenJDK 64-Bit Server VM (build 25.212-b01, mixed mode)
* Apache Maven 3.6.0
* Python 3.6 / Python 2.7 + pip 19.1 + Python3 virtual environments (venv, virtualenv, virtualenvwrapper, mkvirtualenv, ..., etc.)
* Node v11.15.0 + npm 6.7.0 (from NodeSource official Node Distribution)
* Gradle 5.3
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
## Run openrefine web
For more information, please visit: https://github.com/OpenRefine/OpenRefine/releases/ 

Web UI:
```http
Web UI: http://<ip_address>:3333/
```

# Release versions
```
developer@8f86c9444953:/data$ /usr/scripts/printVersions.sh 
+ echo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
+ java -version
openjdk version "1.8.0_212"
OpenJDK Runtime Environment (build 1.8.0_212-8u212-b03-0ubuntu1.18.04.1-b03)
OpenJDK 64-Bit Server VM (build 25.212-b03, mixed mode)
+ mvn --version
Apache Maven 3.6.0 (97c98ec64a1fdfee7767ce5ffb20918da4f719f3; 2018-10-24T18:41:47Z)
Maven home: /usr/apache-maven-3.6.0
Java version: 1.8.0_212, vendor: Oracle Corporation, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "4.18.0-24-generic", arch: "amd64", family: "unix"
+ python -V
Python 2.7.15rc1
+ python3 -V
Python 3.6.7
+ pip --version
pip 19.1.1 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ pip3 --version
pip 19.1.1 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ gradle --version

Welcome to Gradle 5.3.1!

Here are the highlights of this release:
 - Feature variants AKA "optional dependencies"
 - Type-safe accessors in Kotlin precompiled script plugins
 - Gradle Module Metadata 1.0

For more details see https://docs.gradle.org/5.3.1/release-notes.html


------------------------------------------------------------
Gradle 5.3.1
------------------------------------------------------------

Build time:   2019-03-28 09:09:23 UTC
Revision:     f2fae6ba563cfb772c8bc35d31e43c59a5b620c3

Kotlin:       1.3.21
Groovy:       2.5.4
Ant:          Apache Ant(TM) version 1.9.13 compiled on July 10 2018
JVM:          1.8.0_212 (Oracle Corporation 25.212-b03)
OS:           Linux 4.18.0-24-generic amd64

+ npm -v
6.7.0
+ node -v
v11.15.0
+ cat /etc/lsb-release /etc/os-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.2 LTS"
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
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
## Run openrefine web
For more information, please visit: https://github.com/OpenRefine/OpenRefine/releases/ 

Web UI:
```http
Web UI: http://<ip_address>:3333/
```

## Run Python code
To run Python code 

```bash
docker run --rm openkbs/openrefine python -c 'print("Hello World")'
```

or,

```bash
mkdir ./data
echo "print('Hello World')" > ./data/myPyScript.py
docker run -it --rm --name some-openrefine -v "$PWD"/data:/data openkbs/openrefine python myPyScript.py
```

or,

```bash
alias dpy='docker run --rm openkbs/openrefine python'
dpy -c 'print("Hello World")'
```

