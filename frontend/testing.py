import cv2
import numpy as np
import math
import time
from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier
import os
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'

import tensorflow as tf
from tensorflow.keras.layers import DepthwiseConv2D # type: ignore
from tensorflow.keras.models import load_model # type: ignore

# Step 1: Define a custom DepthwiseConv2D layer
class CustomDepthwiseConv2D(DepthwiseConv2D):
    def __init__(self, *args, **kwargs):
        if 'groups' in kwargs:
            kwargs.pop('groups')
        super(CustomDepthwiseConv2D, self).__init__(*args, **kwargs)

    @classmethod
    def from_config(cls, config):
        if 'groups' in config:
            config.pop('groups')
        return cls(**config)

# Step 2: Register the custom layer
tf.keras.utils.get_custom_objects().update({'DepthwiseConv2D': CustomDepthwiseConv2D}) # type: ignore

# Step 3: Load the model
model: tf.keras.Model = load_model('frontend/model/keras_model.h5', custom_objects={'DepthwiseConv2D': CustomDepthwiseConv2D}) # type: ignore


# For webcam input:
cap = cv2.VideoCapture(0)
detect = HandDetector(maxHands=1)
classify = Classifier(modelPath="frontend/model/keras_model.h5", labelsPath="frontend/model/labels.txt")
labels = ['A','B','C']
offset = 20
image_size = 224

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
          
        # Make a prediction
          predictions, index = classify.getPrediction(imgWhite)
          print(predictions)
        else:
          k = image_size / rw 
          hCal = math.ceil(rh * k)
          hGap = math.ceil((image_size - hCal)/2)
          imgResize = cv2.resize(imgRight,(image_size,hCal))
          imgWhite[hGap:hCal+hGap,:] = imgResize     

          predictions, index = classify.getPrediction(imgWhite)
          print(predictions)     
    
        cv2.imshow('white bgs', imgWhite) 
        cv2.imshow('MediaPipe Hands', image)  
    
        cv2.waitKey(1)
    
cap.release()