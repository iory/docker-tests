FROM ros:lunar

MAINTAINER iory ab.ioryz@gmail.com

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-catkin-tools \
    python-rosinstall \
    python-wstool \
    python-pip \
    apt-utils

RUN mkdir -p /ros_ws/src && \
    cd /ros_ws/src && \
    git clone https://github.com/jsk-ros-pkg/jsk_visualization.git && \
    git clone https://github.com/jsk-ros-pkg/jsk_recognition.git && \
    git clone https://github.com/jsk-ros-pkg/jsk_common.git && \
    git clone https://github.com/ros-visualization/view_controller_msgs && \
    git clone https://github.com/wg-perception/people

RUN cd /ros_ws && \
    rosdep update && \
    rosdep install --from-paths --ignore-src -y -r src

RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN source /opt/ros/${ROS_DISTRO}/setup.bash; cd /ros_ws; catkin build jsk_visualization
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
