#!/bin/sh

docker run --rm -it iory/docker-tests:no-pip-numpy bash -i -c 'cd /ros_ws && catkin b -v libsiftfast'
