FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

LABEL maintainer "iory <ab.ioryz@gmail.com>"
LABEL com.nvidia.volumes.needed="driver"

ENV CPATH=/usr/local/include:$CPATH
ENV CUDA_PATH=/usr/local/cuda
ENV PATH=$CUDA_PATH/bin:$PATH
ENV CPATH=$CUDA_PATH/include:$CPATH
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$CUDA_PATH/lib64:$CUDA_PATH/lib:$LD_LIBRARY_PATH

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y --allow-change-held-packages \
    build-essential \
    checkinstall \
    cmake \
    pkg-config \
    yasm \
    git \
    gfortran \
    libjpeg8-dev \
    libjasper-dev \
    libpng12-dev \
    libtiff5-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libdc1394-22-dev \
    libxine2-dev \
    libv4l-dev \
    libgstreamer0.10-dev \
    libgstreamer-plugins-base0.10-dev \
    qt5-default \
    libgtk2.0-dev \
    libtbb-dev \
    libatlas-base-dev \
    libfaac-dev \
    libmp3lame-dev \
    libtheora-dev \
    libvorbis-dev \
    libxvidcore-dev \
    libopencore-amrwb-dev \
    x264 \
    v4l-utils \
    libprotobuf-dev \
    protobuf-compiler \
    libgoogle-glog-dev \
    libgflags-dev \
    libgphoto2-dev \
    libeigen3-dev \
    libhdf5-dev doxygen \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    dirmngr \
    gnupg2 \
    lsb-release \
    python-pip \
    curl \
    git \
    m4 \
    autoconf \
    automake \
    libtool \
    flex \
    libnccl2 \
    libnccl-dev \
    libopencv-dev \
    python-opencv \
    ssh \
    && pip install -U pip \
    && python -m pip install setuptools \
    && python -m pip install opencv-python \
    && python -m pip install virtualenv numpy scipy matplotlib scikit-image scikit-learn ipython \
    && pip3 install -U pip \
    && python3 -m pip install numpy


# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
ENV ROS_DISTRO kinetic
RUN apt-get update && apt-get install -y \
    ros-kinetic-ros-core=1.3.2-0*

RUN DEBIAN_FRONTEND=noninteractive apt install -y --allow-change-held-packages \
    --allow-downgrades \
    libcudnn7=7.0.4.31-1+cuda9.0 \
    libcudnn7-dev=7.0.4.31-1+cuda9.0

# Fetch OpenCV
RUN cd /opt && git clone --verbose https://github.com/opencv/opencv.git -b 3.4.1 &&\
    cd /opt && wget https://github.com/opencv/opencv_contrib/archive/3.4.1.tar.gz &&\
    mkdir opencv_contrib && tar -xf 3.4.1.tar.gz -C opencv_contrib --strip-components 1

RUN cd /opt/opencv && mkdir release && cd release && \
    cmake -G "Unix Makefiles" -DENABLE_PRECOMPILED_HEADERS=OFF -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
      CMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DWITH_TBB=ON -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON \
      -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=OFF -DWITH_QT=ON -DWITH_OPENGL=ON \
      -DWITH_CUDA=ON -DCUDA_GENERATION=Auto -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      .. &&\
      make -j"$(nproc)"  && \
      make install && \
      ldconfig &&\
      cd /opt/opencv/release && make clean

RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    ros-${ROS_DISTRO}-jsk-tools

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
