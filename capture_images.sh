DATE=$(date -u +"%Y-%m-%d_%H-%M-%S")
mkdir -p timelapse/$DATE
ln -sf $DATE timelapse/latest
nohup rpicam-still --timeout 1800000 --timelapse 1000 -o timelapse/$DATE/image%04d.jpg 2>/dev/null & 
