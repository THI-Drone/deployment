#! /bin/bash
docker run --privileged -d -v /run/udev:/run/udev -v /dev/fcc_uart:/dev/fcc_uart -v /home/pi5/deployment/mission_files:/uav/mission_files -v ${PWD}/log:/log -v ${PWD}/images:/images -it --network host --rm "$@"
