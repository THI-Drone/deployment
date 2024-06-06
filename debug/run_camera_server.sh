#! /bin/bash
docker run --privileged -v /run/udev:/run/udev -v ${PWD}:/debug -w /debug --entrypoint /bin/bash -it -p 80:8000 --rm thi_drone_software -c python3 camera_server.py "$@"
