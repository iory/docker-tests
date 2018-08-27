FROM ros:indigo

LABEL maintainer "iory <ab.ioryz@gmail.com>"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-catkin-tools \
    python-rosinstall \
    python-wstool \
    ros-${ROS_DISTRO}-jsk-tools

RUN mkdir -p /ros_ws/src && \
    cd /ros_ws/src && \
    git clone --depth 1 -b kinetic-speak https://github.com/iory/jsk_pr2eus && \
    git clone --depth 1 -b 0.3.3 https://github.com/ros-drivers/audio_common && \
    rm -rf jsk_pr2eus/.git && \
    rm -rf audio_common/.git

RUN cd /ros_ws && \
    rosdep update && \
    apt update && \
    rosdep install --from-paths --ignore-src -y -r src && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN source /opt/ros/${ROS_DISTRO}/setup.bash; cd /ros_ws; catkin build
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh
RUN touch /root/.bashrc && \
    echo "source /ros_ws/devel/setup.bash\n" >> /root/.bashrc && \
    echo "rossetip\n" >> /root/.bashrc && \
    echo "rossetmaster localhost"

COPY ./ros_entrypoint.sh /
COPY ./audio.launch /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
