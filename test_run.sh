#!/bin/bash

set -eu

name=cl-devel2

docker rmi $(docker images | awk '/^<none>/ { print $3 }') || echo "ignore rmi error"
docker rm `docker ps -a -q` || echo "ignore rm error"

docker build -t ${name}:latest .
docker run --name cl-devel2 -v ~/work/lisp:/root/work -it ${name}:latest /bin/sh
