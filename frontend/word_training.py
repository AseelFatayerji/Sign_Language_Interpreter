import cv2
from cvzone.HandTrackingModule import HandDetector

# For webcam input:
cap = cv2.VideoCapture(0)
detect = HandDetector(maxHands=2)

while cap.isOpened():
    success, image = cap.read()
    if not success:
      print("Ignoring empty camera frame.")
      # If loading a video, use 'break' instead of 'continue'.
      break
    
    hands, image = detect.findHands(image)              
    if hands:
        right = hands[0]
        left = hands[1]
        if right:
          rx, ry, rw, rh = right['bbox']
          imgRight = image[ry:ry+rh, rx:rx + rw]
          cv2.imshow('crop right hands', imgRight)
        if left:          
            lx, ly, lw, lh = left['bbox']
            imgLeft = image[ly:ly+lh, lx:lx + lw]
            cv2.imshow('crop left hands', imgLeft)


    cv2.imshow('MediaPipe Hands', image)
    cv2.waitKey(1)
    
cap.release()