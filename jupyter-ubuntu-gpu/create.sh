#! /bin/bash

docker create -it -e TZ=Asia/Tokyo --gpus all --name jupgdeb39 -p 8888:8888 --mount type=bind,source=/mnt/share,target=/jnote -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -u $(id -u $USER):$(id -g $USER) jupyter:g-deb3.9


#docker run -it -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -u $(id -u $USER):$(id -g $USER) ubuntu bash
