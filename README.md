# Docker Container Deployment

This repository combines all the scripts and files needed to deploy the mission software in a Docker container on the Raspberry Pi.

The following steps need to be executed:

## Make Scripts Executable

```sh
sudo chmod +x docker_build.sh
sudo chmod +x docker_run.sh
```

## Build Image

```sh
./docker_build.sh
```

## Run Container

Example:

```sh
./docker_run.sh UAV_ID:=UAV_FFI_4 MDF_FILE_PATH:=/uav/mission_files/HIL/mdf_zuerich.json sim:=false namespace:=uav
```

## Other files

The following files are used by the build and run process and therefore shall not be altered or executed by you:

### `install-mavsdk.sh`

Build script used to to install MavSDK in the `Dockerfile`.

### `Build.sh`

Build script used to build the mission software in the `Dockerfile`.

### `Dockerfile`

Dockerfile used to build the Docker image.

### `launch.sh`

Launch file executed by the Docker container upon running.
