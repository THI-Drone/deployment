#! /bin/bash
docker run --privileged -d -v /run/udev:/run/udev -v /dev/serial0:/dev/serial0 -v /home/pi5/deployment/mission_files:/uav/mission_files -v ${PWD}/log:/log -v ${PWD}/bag:/bag -it --network host --rm thi_drone_software "$@"
