#!/bin/bash

docker build --build-arg ROS_DISTRO="$1" --no-cache -t iory/jsk_visualization:685-"$1" .
