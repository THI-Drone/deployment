DATE=$(date -u +"%Y-%m-%d_%H-%M-%S")
mkdir -p timelapse/$DATE
rpicam-still --timeout 1800000 --timelapse 1000 timelapse/$DATE
