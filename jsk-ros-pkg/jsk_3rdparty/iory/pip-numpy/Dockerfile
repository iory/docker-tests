FROM ros:kinetic

LABEL maintainer "iory <ab.ioryz@gmail.com>"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-catkin-tools \
    python-pip

RUN pip install numpy

RUN mkdir -p /ros_ws/src && \
    cd /ros_ws/src && \
    git clone --depth 1 -b kinetic-speak https://github.com/jsk-ros-pkg/jsk_3rdparty

RUN cd /ros_ws && \
    rosdep update && \
    apt update && \
    rosdep install --from-paths --ignore-src -y -r src && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

CMD ["bash"]
