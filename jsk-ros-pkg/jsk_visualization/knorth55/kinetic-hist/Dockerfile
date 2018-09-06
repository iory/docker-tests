FROM ros:kinetic

MAINTAINER iory ab.ioryz@gmail.com

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-catkin-tools \
    python-rosinstall \
    python-wstool \
    ros-${ROS_DISTRO}-jsk-tools \
    python-sklearn

RUN mkdir -p /ros_ws/src && \
    cd /ros_ws/src && \
    git clone https://github.com/jsk-ros-pkg/jsk_visualization.git


RUN cd /ros_ws && \
    rosdep update && \
    apt update && \
    rosdep install --from-paths --ignore-src -y -r src

RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN source /opt/ros/${ROS_DISTRO}/setup.bash; cd /ros_ws; catkin build
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh
RUN touch /root/.bashrc && \
    echo "source /ros_ws/devel/setup.bash\n" >> /root/.bashrc && \
    echo "rossetip\n" >> /root/.bashrc && \
    echo "rossetmaster localhost"

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
