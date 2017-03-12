# Java 8 (1.8.0_92) JRE server + Maven 3.3.9 + Python 2.7.11

[![](https://imagelayers.io/badge/openkbs/openrefine:1.0.0.svg)](https://imagelayers.io/?images=openkbs/openrefine:1.0.0 'Get your own badge on imagelayers.io')

Components:

* openrefine 2.1.2 service at http://<server_ip:9999>/
* OpenRefine 2.6.2rc http://<server_ip:3333>/
* Oracle Java "1.8.0_92" JRE Runtime Environment for Server
  Java(TM) SE Runtime Environment (build 1.8.0_92-b14)
  Java HotSpot(TM) 64-Bit Server VM (build 25.92-b14, mixed mode)
* Apache Maven 3.3.9
* Python 2.7.11
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

## Pull the image from Docker Repository

```bash
docker pull openkbs/openrefine
```

## Base the image to build add-on components

```Dockerfile
FROM openkbs/openrefine
```

## Run the image

Then, you're ready to run :
Make sure you create your work directory, e.g., /data

```bash
mkdir ./data
docker run -d --name my-openrefine -v $PWD/data:/data -i -t openkbs/openrefine
```

## Build and Run your own image

Say, you will build the image "my/openrefine".

```bash
docker build -t my/openrefine .
```

To run your own image, say, with some-openrefine:

```bash
mkdir ./data
docker run -d --name some-openrefine -v $PWD/data:/data -i -t my/openrefine
```

## Shell into the Docker instance
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

