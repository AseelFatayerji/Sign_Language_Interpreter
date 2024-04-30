import cv2
import numpy as np
import math
import time
from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier

# For webcam input:
cap = cv2.VideoCapture(0)
detect = HandDetector(maxHands=1)
classify = Classifier("model/keras_model.h5", "model/labels.txt")
labels = ['A','B','C']
offset = 20
image_size = 300
count = 0

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
        #   prediction , index = classify.getPrediction(image)
        #   print(prediction,index)
        else:
          k = image_size / rw 
          hCal = math.ceil(rh * k)
          hGap = math.ceil((image_size - hCal)/2)
          imgResize = cv2.resize(imgRight,(image_size,hCal))
          imgWhite[hGap:hCal+hGap,:] = imgResize          
    
        cv2.imshow('white bgs', imgWhite) 
        cv2.imshow('MediaPipe Hands', image)  
    
        cv2.waitKey(1)
    
cap.release()