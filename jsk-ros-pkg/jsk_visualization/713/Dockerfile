FROM ros:kinetic

LABEL maintainer "iory <ab.ioryz@gmail.com>"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-catkin-tools \
    python-rosinstall \
    python-wstool \
    ros-${ROS_DISTRO}-jsk-tools \
    python-sklearn

RUN mkdir -p /ros_ws/src && \
    cd /ros_ws/src && \
    git clone --depth 1 https://github.com/jsk-ros-pkg/jsk_visualization.git && \
    git clone --depth 1 https://github.com/jsk-ros-pkg/jsk_common

RUN cd /ros_ws && \
    rosdep update && \
    apt update && \
    rosdep install --from-paths --ignore-src -y -r src

RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN source /opt/ros/${ROS_DISTRO}/setup.bash; cd /ros_ws; catkin build jsk_visualization
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh
RUN touch /root/.bashrc && \
    echo "source /ros_ws/devel/setup.bash\n" >> /root/.bashrc && \
    echo "rossetip\n" >> /root/.bashrc && \
    echo "rossetmaster localhost"

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
