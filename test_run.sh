#!/bin/bash

set -eu

name=cl-devel2

no_cache_opt=
if [ $? -ge 1 ]; then
  no_cache_opt="--no-cache"
fi

docker rmi $(docker images | awk '/^<none>/ { print $3 }') || echo "ignore rmi error"
docker rm `docker ps -a -q` || echo "ignore rm error"

docker build ${no_cache_opt} -t ${name}:latest .
docker run --name ${name} -v ~/work/lisp:/root/work -v "$(pwd)/sample-custom-el":/root/.emacs.d/site-lisp/custom -it ${name}:latest /bin/ash
