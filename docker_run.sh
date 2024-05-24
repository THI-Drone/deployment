#! /bin/bash
docker run --privileged -v /run/udev:/run/udev -v /dev/serial0:/dev/serial0  -it --network host --rm thi_drone_software "$@"
