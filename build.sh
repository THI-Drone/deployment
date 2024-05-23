#! /bin/bash
source /opt/ros/humble/setup.bash
colcon build --cmake-args -DBUILD_TESTING=OFF --packages-up-to mission_software_launch
