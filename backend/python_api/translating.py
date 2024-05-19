import cv2
import numpy as np
import math
import os
import tensorflow as tf
import cv2
import time

import base64
from PIL import Image
from io import BytesIO

from typing import List
from click import File

from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier

from fastapi import FastAPI, File, Form, UploadFile

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

model= tf.keras.models.load_model(file_path, custom_objects={'DepthwiseConv2D': CustomDepthwiseConv2D}) # type: ignore
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
detect = HandDetector(maxHands=2,detectionCon=0.8)
classify = Classifier(modelPath=file_path, labelsPath=labels)
  
app = FastAPI()
@app.post('/translate')

async def tanslate(image: str = Form(...)):
   offset = 2
   image_size = 200
   try:
        image_data = base64.b64decode(image)
        nparr = np.frombuffer(image_data, np.uint8)
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        hands, images = detect.findHands(img)
        if hands:
          if len(hands) == 1:
            for hand in hands:
              x, y, w, h = hand['bbox']
              imgWhite = np.ones((image_size,image_size,3),np.uint8)*255
              imgRight = images[y-offset:y+h+offset, x-offset:x +w+offset]
              ratio = h / w
              if ratio > 1:
                k = image_size / h 
                wCal = math.ceil(w * k)
                wGap = math.ceil((image_size - wCal)/2)
                imgResize = cv2.resize(imgRight,(wCal,image_size))
                imgWhite[:, wGap:wCal+wGap] = imgResize      
                _, index = classify.getPrediction(imgWhite)
          
                return{predict[index]}
        
              else:
                k = image_size / w 
                hCal = math.ceil(h * k)
                hGap = math.ceil((image_size - hCal)/2)
                imgResize = cv2.resize(imgRight,(image_size,hCal))
                imgWhite[hGap:hCal+hGap,:] = imgResize     
                _, index = classify.getPrediction(imgWhite)
                
                return{predict[index]}
          else:
              x1, y1, w1, h1 = hands[0]['bbox']
              x2, y2, w2, h2 = hands[1]['bbox']

              min_x = min(x1, x2)
              min_y = min(y1, y2)
              max_x = max(x1 + w1, x2 + w2)
              max_y = max(y1 + h1, y2 + h2)

              cropped_width = max_x - min_x + 40  
              cropped_height = max_y - min_y + 40 


              scale_factor = max(1, max(cropped_width / 400, cropped_height / 400))

              cropped_hands_resized = cv2.resize(images[min_y:max_y, min_x:max_x], None, fx=1/scale_factor, fy=1/scale_factor)

              background = np.ones((400, 400, 3), dtype=np.uint8) * 255

              offset_x = int((400 - cropped_hands_resized.shape[1]) / 2)
              offset_y = int((400 - cropped_hands_resized.shape[0]) / 2)

              background[offset_y:offset_y+cropped_hands_resized.shape[0], offset_x:offset_x+cropped_hands_resized.shape[1]] = cropped_hands_resized
              predictions, index = classify.getPrediction(background)
          
              return{predict[index]}
        else:
           return{"No hands"}
   except Exception as e:
       return(f"Error decoding base64 string: {e}")
        
# @app.post('/oneHand')
# async def update(label:str,images: List[UploadFile] = File(...)):
#    folder = 'frontend/data/letters/'+label
#    offset = 20
#    newData = []
#    new_label = (str(len(lines))+" " + label + "\n")
#    image_size = 400
#    for image in images:
#       content = await image.read()
#       nparr = np.frombuffer(content, np.uint8)
#       image_data = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
#       hands, new_image = detect.findHands(image_data)
   
#       if hands:
#         for hand in hands:
        
#           x, y, w, h = hand['bbox']
#           imgWhite = np.ones((image_size,image_size,3),np.uint8)*255
#           imgRight = new_image[y-offset:y+h+offset, x-offset:x +w+offset]
#           ratio = h / w
#           if ratio > 1:
#             k = image_size / h 
#             wCal = math.ceil(w * k)
#             wGap = math.ceil((image_size - wCal)/2)
#             imgResize = cv2.resize(imgRight,(wCal,image_size))
#             imgWhite[:, wGap:wCal+wGap] = imgResize  
#             cv2.imwrite(f'{folder}/Image_{time.time()}.jpg', imgWhite)
#             newData.append(imgWhite)
        
#           else:
#             k = image_size / w 
#             hCal = math.ceil(h * k)
#             hGap = math.ceil((image_size - hCal)/2)
#             imgResize = cv2.resize(imgRight,(image_size,hCal))
#             imgWhite[hGap:hCal+hGap,:] = imgResize     
#             newData.append(imgWhite)
            
#    with open('model/labels.txt', 'a') as file:
#       file.write(new_label)
#    set_labels = np.array([label]*len(newData))
#    history = model.fit(newData,set_labels, epochs=5)
#    history.save(file_path)
#    return{"model saved"}