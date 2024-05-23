#! /bin/bash
docker run thi_drone_software --privileged -v /run/udev:/run/udev --device=/dev/ttyAMA0
