
from cProfile import label
import io
import cv2
import numpy as np
import math
import os
import tensorflow as tf
import cv2

from PIL import Image

from click import File

from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier

from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse

from tensorflow.keras.layers import DepthwiseConv2D # type: ignore
from tensorflow.keras.models import load_model # type: ignore

os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
    
file_path = os.path.abspath('model/keras_model.h5')
labels = os.path.abspath('model/labels.txt')
with open('model/labels.txt', 'r') as file:
    lines = file.read().splitlines()

predict = [string[2:] for string in lines]

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

tf.keras.utils.get_custom_objects().update({'DepthwiseConv2D': CustomDepthwiseConv2D}) # type: ignore

model: tf.keras.Model = load_model(file_path, custom_objects={'DepthwiseConv2D': CustomDepthwiseConv2D}) # type: ignore
detect = HandDetector(maxHands=1,detectionCon=0.8)
classify = Classifier(modelPath=file_path, labelsPath=labels)

app = FastAPI()
@app.post('/translate',)

async def root(image: UploadFile = File(...)):
   offset = 20
   image_size = 400
   content = await image.read()
   nparr = np.frombuffer(content, np.uint8)
   image_data = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
   hands, images = detect.findHands(image_data)
   
   if hands:
        right = hands[0]
        
        rx, ry, rw, rh = right['bbox']
        imgWhite = np.ones((image_size,image_size,3),np.uint8)*255
        imgRight = images[ry-offset:ry+rh+offset, rx-offset:rx +rw+offset]
        ratio = rh / rw
        if ratio > 1:
          k = image_size / rh 
          wCal = math.ceil(rw * k)
          wGap = math.ceil((image_size - wCal)/2)
          imgResize = cv2.resize(imgRight,(wCal,image_size))
          imgWhite[:, wGap:wCal+wGap] = imgResize      
          
          predictions, index = classify.getPrediction(imgWhite)
          
          return{"prediction":predict[index]}
        
        else:
          k = image_size / rw 
          hCal = math.ceil(rh * k)
          hGap = math.ceil((image_size - hCal)/2)
          imgResize = cv2.resize(imgRight,(image_size,hCal))
          imgWhite[hGap:hCal+hGap,:] = imgResize     

          predictions, index = classify.getPrediction(imgWhite)
          
          return{"prediction":predict[index]}
