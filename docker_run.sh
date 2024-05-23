#! /bin/bash
docker run --privileged -v /run/udev:/run/udev --device=/dev/ttyAMA0 thi_drone_software
