#!/bin/bash

xhost +local:root
docker run -it --rm \
       iory/jsk_recognition:opencv-"$1"
xhost -local:root
