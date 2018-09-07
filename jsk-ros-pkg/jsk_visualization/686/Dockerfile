ARG ROS_DISTRO
FROM osrf/ros:${ROS_DISTRO}-desktop-full

LABEL maintainer "iory <ab.ioryz@gmail.com>"
LABEL com.nvidia.volumes.needed="driver"
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# https://github.com/tmux/tmux/issues/257#issuecomment-245315362
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-catkin-tools \
    python-rosinstall \
    python-wstool \
    python-pip \
    libxext-dev \
    libx11-dev \
    x11proto-gl-dev \
    autoconf \
    automake \
    m4 \
    libtool \
    perl \
    pkg-config \
    ros-${ROS_DISTRO}-jsk-tools

RUN mkdir -p /src && \
    cd /src && \
    git clone https://github.com/NVIDIA/libglvnd && \
    cd libglvnd && \
    ./autogen.sh && \
    ./configure && \
    make -j && \
    make install

RUN mkdir -p /ros_ws/src && \
    cd /ros_ws/src && \
    git clone -b fix_685 https://github.com/k-okada/jsk_visualization.git && \
    git clone https://github.com/jsk-ros-pkg/jsk_common

RUN cd /ros_ws && \
    rosdep update && \
    rosdep install --from-paths --ignore-src -y -r src

RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN source /opt/ros/${ROS_DISTRO}/setup.bash; cd /ros_ws; catkin build jsk_visualization
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
