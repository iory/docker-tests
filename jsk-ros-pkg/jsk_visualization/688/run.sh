#!/bin/bash

xhost +local:
docker run -it --rm \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -e DISPLAY=$DISPLAY \
       iory/knorth55-kinetic-plot-2d bash -i -c 'roslaunch jsk_rqt_plugins sample_2dplot.launch'
xhost -local:
