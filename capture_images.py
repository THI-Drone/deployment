from picamera2 import Picamera2
import cv2
import time
import datetime
import os

picam2 = Picamera2()
config = picam2.create_still_configuration(main={"size": (2048, 1536), 'format': 'RGB888',})
picam2.configure(config)
picam2.start()
time.sleep(1)

current_datetime = datetime.datetime.now()
time_string = current_datetime.strftime("%Y-%m-%d_%H-%M-%S")
image_path = f'images/continuous/{time_string}'

if not os.path.exists(image_path):
    os.makedirs(image_path)

numImg = 1

try:
    while True:
        img_array = picam2.capture_array("main")
        img_path = f'{image_path}/{numImg}_successfully_detected.jpg'
        cv2.imwrite(img_path, img_array)
        numImg += 1
        time.sleep(1) 
except KeyboardInterrupt:
    print("Aufnahme beendet.")
except Exception as e:
    print(f"Ein Fehler ist aufgetreten: {e}")
