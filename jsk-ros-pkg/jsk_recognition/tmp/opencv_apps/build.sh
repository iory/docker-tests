#!/bin/bash

docker build --build-arg ROS_DISTRO="$1" -t iory/jsk_recognition:opencv-"$1" .
