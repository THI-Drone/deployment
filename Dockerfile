# ********************************************************
# * FIRST STAGE *
# ********************************************************

FROM ros:humble AS base

WORKDIR /uav

# Upgrade Ubuntu packages to latest version
RUN apt-get update && apt-get upgrade -y

# Install python3
RUN apt-get install -y python3-pip
# Install useful tooling
RUN apt-get install -y ssh vim

# C++ JSON lib
RUN apt-get install -y nlohmann-json3-dev

# LibGL Dependency
RUN apt-get install -y libgl1-mesa-glx

# Autoformatter for C++ / Python
RUN apt-get install -y clang-format
RUN apt-get install -y python3-autopep8

# Make sure ROS is sourced in every bash shell in the container
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc
# Set the default shell to bash (rather than sh)
ENV SHELL /bin/bash

# Fix Python deprecated warnings when using ROS2
RUN pip install setuptools==58.2.0

# Install required dependencies so that picamera2 can used
RUN apt update && apt install -y --no-install-recommends gnupg
RUN apt update && apt install -y --no-install-recommends \
    meson \
    ninja-build \
    pkg-config \
    libyaml-dev \
    python3-yaml \
    python3-ply \
    python3-jinja2 \
    libevent-dev \
    libdrm-dev \
    libcap-dev \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

# Install libcamera from source
RUN git clone https://github.com/raspberrypi/libcamera.git
RUN meson setup libcamera/build libcamera/
RUN ninja -C libcamera/build/ install


# Install kmsxx from source
RUN git clone https://github.com/tomba/kmsxx.git
RUN meson setup kmsxx/build kmsxx/
RUN ninja -C kmsxx/build/ install 

# Add the new installations to the python path so that picamera2 can find them
ENV PYTHONPATH $PYTHONPATH/usr/local/lib/aarch64-linux-gnu/python3.10/site-packages:/uav/kmsxx/build/py

# Finally install picamera2 & opencv using pip
RUN pip3 install picamera2 opencv-python

# MAVLINK lib
COPY install-mavsdk.sh /tmp/
RUN chmod +x /tmp/install-mavsdk.sh && /tmp/install-mavsdk.sh && rm /tmp/install-mavsdk.sh

# ********************************************************
# * SECOND STAGE *
# ********************************************************

FROM base AS build

# Make sure the second stage is always redone (in order to force a clean git pull)
ENV GIT_CLONE_TIME = $(date +%s)

# clone the workspace repo
RUN git clone --recursive https://github.com/THI-Drone/thi-drone-ws.git --branch 19-add-mission-file-reader-subrepo
WORKDIR /uav/thi-drone-ws

# build shell script which sources ROS and calls colcon build
COPY build.sh .
RUN chmod +x build.sh && ./build.sh

# Make sure our workspace is sourced in every bash
RUN echo "source /uav/thi-drone-ws/install/setup.bash" >> /root/.bashrc 

# ********************************************************
# * THIRD STAGE *
# ********************************************************

FROM build AS run
# Use ros2 launch to start all of the Nodes required on the drone using bash script workaround for sourcing
COPY launch.sh .
RUN chmod +x launch.sh
ENTRYPOINT ["./launch.sh"]
