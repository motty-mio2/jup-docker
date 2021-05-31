#!/bin/bash

docker create -it -e TZ=Asia/Tokyo --name jupdeb39 -p 8888:8888 -u $(id -u $USER) --mount type=bind,source=~/jnote,target=/jnote --mount type=bind,source=/etc/passwd,target=/etc/passwd:ro --mount type=bind,source=/etc/group,target=/etc/group:ro jupyter:deb3.9