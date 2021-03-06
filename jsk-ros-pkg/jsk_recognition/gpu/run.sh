#!/bin/bash

xhost +local:root
docker run -it --rm \
       --runtime=nvidia \
       --env="DISPLAY" \
       --env="QT_X11_NO_MITSHM=1" \
       --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
       iory/jsk_recognition:kinetic bash
xhost -local:root
