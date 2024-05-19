import cv2
import numpy as np
import math
import os
import tensorflow as tf
import cv2
import time
from typing import List
from click import File

from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier

from fastapi import FastAPI, File, UploadFile

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

app = FastAPI()
@app.post('/oneHand',)
async def update(label:str,images: List[UploadFile] = File(...)):
   folder = 'frontend/data/letters/'+label
   offset = 20
   newData = []
   new_label = ""
   image_size = 400
   for image in images:
      content = await image.read()
      nparr = np.frombuffer(content, np.uint8)
      image_data = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
      hands, new_image = detect.findHands(image_data)
   
      if hands:
        for hand in hands:
        
          x, y, w, h = hand['bbox']
          imgWhite = np.ones((image_size,image_size,3),np.uint8)*255
          imgRight = new_image[y-offset:y+h+offset, x-offset:x +w+offset]
          ratio = h / w
          if ratio > 1:
            k = image_size / h 
            wCal = math.ceil(w * k)
            wGap = math.ceil((image_size - wCal)/2)
            imgResize = cv2.resize(imgRight,(wCal,image_size))
            imgWhite[:, wGap:wCal+wGap] = imgResize  
            cv2.imwrite(f'{folder}/Image_{time.time()}.jpg', imgWhite)   
            new_label = (str(len(lines))+" " + label) 
            newData.append(imgWhite)
        
          else:
            k = image_size / w 
            hCal = math.ceil(h * k)
            hGap = math.ceil((image_size - hCal)/2)
            imgResize = cv2.resize(imgRight,(image_size,hCal))
            imgWhite[hGap:hCal+hGap,:] = imgResize     
            new_label = (str(len(lines))+" " + label) 
            newData.append(imgWhite)
            
   with open('model/labels.txt', 'r') as file:
      file.write(new_label+"\n")
   set_labels = np.array([label]*len(newData))
   history = model.fit(newData,set_labels, epochs=5)
   history.save(file_path)
