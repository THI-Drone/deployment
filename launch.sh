#! /bin/bash
source /opt/ros/humble/setup.bash
source /uav/thi-drone-ws/install/setup.bash
ros2 launch mission_software_launch launch.py "$@"
