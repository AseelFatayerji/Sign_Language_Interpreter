import cv2
import numpy as np
from cvzone.HandTrackingModule import HandDetector
import time


cap = cv2.VideoCapture(0)
detect = HandDetector(maxHands=2)
folder = 'frontend/data/words/name'

while cap.isOpened():
    success, image = cap.read()
    if not success:
        print("Ignoring empty camera frame.")
        break

  
    hands, image = detect.findHands(image)

    if len(hands) == 2:
 
        x1, y1, w1, h1 = hands[0]['bbox']
        x2, y2, w2, h2 = hands[1]['bbox']

        min_x = min(x1, x2)
        min_y = min(y1, y2)
        max_x = max(x1 + w1, x2 + w2)
        max_y = max(y1 + h1, y2 + h2)

        cropped_width = max_x - min_x + 40  
        cropped_height = max_y - min_y + 40 


        scale_factor = max(1, max(cropped_width / 400, cropped_height / 400))

        cropped_hands_resized = cv2.resize(image[min_y:max_y, min_x:max_x], None, fx=1/scale_factor, fy=1/scale_factor)

        background = np.ones((400, 400, 3), dtype=np.uint8) * 255

        offset_x = int((400 - cropped_hands_resized.shape[1]) / 2)
        offset_y = int((400 - cropped_hands_resized.shape[0]) / 2)

        background[offset_y:offset_y+cropped_hands_resized.shape[0], offset_x:offset_x+cropped_hands_resized.shape[1]] = cropped_hands_resized

        cv2.imshow('Cropped Hands', background)

        count = 0
        cv2.waitKey(1)
        time.sleep(4)
        while count != 200:
              count += 1
              cv2.imwrite(f'{folder}/Image_{time.time()}.jpg', background)
              print(count)
              time.sleep(0.1)

cap.release()
