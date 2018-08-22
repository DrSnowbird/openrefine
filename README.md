# Java 8 (1.8.0_181) JDK + Maven 3.5 + Python 3.5 
[![](https://images.microbadger.com/badges/image/openkbs/openrefine.svg)](https://microbadger.com/images/openkbs/openrefine "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/openrefine.svg)](https://microbadger.com/images/openkbs/openrefine "Get your own version badge on microbadger.com")

# License Agreement
By using this image, you agree the [Oracle Java JDK License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).
This image contains [Oracle JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html). You must accept the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) to use this image.

# Components:
* OpenRefine 2.7-rc.2 http://<server_ip:3333>/
* Oracle Java "1.8.0_162" JDK 
* Apache Maven 3.5.0
* Python 3.5.2
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

# Run (Recommended for easy start up!)

Then, you're ready to run :
Make sure you create your work directory, e.g., /data

```bash
mkdir ./data
docker run -d --name my-openrefine -v $PWD/data:/data -i -t openkbs/openrefine
```

# Pull image

```bash
docker pull openkbs/openrefine
```

# Base the image to build add-on applications

```Dockerfile
FROM openkbs/openrefine
```

# Build

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

