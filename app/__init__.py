from fastapi import FastAPI, File, UploadFile 
import tensorflow as tf
from keras.models import load_model
import json 
import numpy as np
import cv2
# import scipy
# from PIL import Image
# import scipy.ndimage
 
app = FastAPI() 
input_img_size = 256
model = load_model('cnn2breastcancer.hdf5', compile = False)    

def resize_img(img):
    img=cv2.resize(img,(input_img_size,input_img_size))
    return img

@app.post('/')
async def scoring_endpoint(data: UploadFile = File(...)): 
    image_bytes = await data.read()
    image = tf.io.decode_image(image_bytes)
    image = np.array(image).astype('uint8')
    image = resize_img(image)
    image = np.array(image)
    yhat = model.predict(tf.expand_dims(image, axis=0))
    predicted_class = np.argmax(yhat)
    print(image.shape)
    return {"Tumor Detection": json.dumps(predicted_class.tolist())}
     
@app.route("/test")
def test():
    return "The cloud api is connected"