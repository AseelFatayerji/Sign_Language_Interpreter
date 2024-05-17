import cv2
import numpy as np
from cvzone.HandTrackingModule import HandDetector

# For webcam input:
cap = cv2.VideoCapture(0)
detect = HandDetector(maxHands=2)

while cap.isOpened():
    success, image = cap.read()
    if not success:
        print("Ignoring empty camera frame.")
        break

    # Find hands in the image
    hands, image = detect.findHands(image)

    if len(hands) == 2:
        # Get the bounding box coordinates for both hands
        x1, y1, w1, h1 = hands[0]['bbox']
        x2, y2, w2, h2 = hands[1]['bbox']

        # Find the minimum bounding rectangle that encompasses both hands
        min_x = min(x1, x2)
        min_y = min(y1, y2)
        max_x = max(x1 + w1, x2 + w2)
        max_y = max(y1 + h1, y2 + h2)

        # Calculate the dimensions for the cropped image
        cropped_width = max_x - min_x + 40  # Add an offset of 20 pixels on each side
        cropped_height = max_y - min_y + 40  # Add an offset of 20 pixels on each side

        # Calculate the scaling factor for resizing
        scale_factor = max(1, max(cropped_width / 400, cropped_height / 400))

        # Resize the cropped hands
        cropped_hands_resized = cv2.resize(image[min_y:max_y, min_x:max_x], None, fx=1/scale_factor, fy=1/scale_factor)

        # Create a white background image of size 400x400
        background = np.ones((400, 400, 3), dtype=np.uint8) * 255

        # Calculate the offset for placing the cropped hands onto the background
        offset_x = int((400 - cropped_hands_resized.shape[1]) / 2)
        offset_y = int((400 - cropped_hands_resized.shape[0]) / 2)

        # Place the cropped hands onto the white background
        background[offset_y:offset_y+cropped_hands_resized.shape[0], offset_x:offset_x+cropped_hands_resized.shape[1]] = cropped_hands_resized

        # Display the cropped image with both hands on a white background
        cv2.imshow('Cropped Hands', background)

    # Show the original image with hand bounding boxes
    # cv2.imshow('Original Image', image)
    cv2.waitKey(1)

cap.release()
