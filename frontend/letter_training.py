import cv2
import numpy as np
import math
import time
from cvzone.HandTrackingModule import HandDetector

# For webcam input:
cap = cv2.VideoCapture(0)
detect = HandDetector(maxHands=1)

offset = 20
image_size = 300
count = 0

folder = 'C:/Users/BOB/Desktop/Boot Camp/Sign_Language_Interpreter/frontend/data/letters/a'
while cap.isOpened():
    success, image = cap.read()
    if not success:
      print("Ignoring empty camera frame.")
      # If loading a video, use 'break' instead of 'continue'.
      break
    
    hands, image = detect.findHands(image)              
    if hands:
        right = hands[0]
        rx, ry, rw, rh = right['bbox']
        imgWhite = np.ones((image_size,image_size,3),np.uint8)*255
        imgRight = image[ry-offset:ry+rh+offset, rx-offset:rx +rw+offset]
        ratio = rh / rw
        if ratio > 1:
          k = image_size / rh 
          wCal = math.ceil(rw * k)
          wGap = math.ceil((image_size - wCal)/2)
          imgResize = cv2.resize(imgRight,(wCal,image_size))
          imgWhite[:, wGap:wCal+wGap] = imgResize      
          
        else:
          k = image_size / rw 
          hCal = math.ceil(rh * k)
          hGap = math.ceil((image_size - hCal)/2)
          imgResize = cv2.resize(imgRight,(image_size,hCal))
          imgWhite[hGap:hCal+hGap,:] = imgResize          
    
        cv2.imshow('white bgs', imgWhite) 
        cv2.imshow('MediaPipe Hands', image)  
    
        key = cv2.waitKey(1)
        if key == ord('s'):
          count += 1
          cv2.imwrite(f'{folder}/Image_{time.time()}.jpg', imgWhite)
          print(count)
    
cap.release()