#! /bin/bash
docker build . --build-arg GIT_CLONE_TIME=`date +%s` --tag thi_drone_software
