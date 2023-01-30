from fastapi import FastAPI, File, UploadFile 
import tensorflow as tf
from tensorflow import keras
import json 
from pydantic import BaseModel
import numpy as np
import cv2
import scipy
from PIL import Image
import scipy.ndimage
 
app = FastAPI() 
input_img_size = 224
model = keras.models.load_model('seg_model_.h5', compile = False) 


def resize_img(img):
    img=cv2.resize(img,(input_img_size,input_img_size))
    return img


@app.post('/')
async def scoring_endpoint(data: UploadFile = File(...)): 
    image_bytes = await data.read()
    image = tf.io.decode_image(image_bytes)
    image = np.array(image).astype('uint8')
    image = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
    image = resize_img(image)
    image = image / 255.0
    image=image[...,np.newaxis]
    yhat = model.predict(tf.expand_dims(image, axis=0))
    yhat = yhat[0]
    yhat[:,:,0] = yhat[:,:,0]*255.0
    return {"Bengin Segmentation": json.dumps(yhat[:, :, 0].tolist()), "Tumor Percentage": json.dumps((len(yhat[:, :, 0] >0.5)/(224*224))*100)}
    
     
   