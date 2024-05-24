#! /bin/bash
docker run thi_drone_software --privileged -v /run/udev:/run/udev -v /dev/ttyAMA0:/dev/serial0  --network host
