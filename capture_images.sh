DATE=$(date -u +"%Y-%m-%d_%H-%M-%S")
mkdir -p timelapse/$DATE
nohup rpicam-still --timeout 1800000 --timelapse 1000 imelapse/$DATE &
