#!/bin/bash

xhost +local:
docker run -it --rm \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -e DISPLAY=$DISPLAY \
       iory/jsk_visualization:705
xhost -local:
