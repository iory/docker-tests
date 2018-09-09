ARG ROS_DISTRO
FROM library/ros:${ROS_DISTRO}-ros-core

LABEL maintainer "iory <ab.ioryz@gmail.com>"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-catkin-tools \
    python-rosinstall \
    python-wstool \
    python-pip \
    ros-${ROS_DISTRO}-jsk-tools

RUN mkdir -p /ros_ws/src && \
    cd /ros_ws/src && \
    git clone --depth 1 https://github.com/jsk-ros-pkg/jsk_recognition.git

RUN cd /ros_ws && \
    rosdep update && \
    apt update && \
    rosdep install --from-paths --ignore-src -y -r src

CMD ["bash"]
