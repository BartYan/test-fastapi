from fastapi import FastAPI
from fastapi import UploadFile, File
import uvicorn
from prediction import predict
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://0.0.0.0:3000",
    "http://127.0.0.1:3000",
    "http://fastapi:3000"
    # "http://localhost:3000/chordzapp",
    # "http://localhost:8080",
    # "http://localhost:8080/index?name=Bart"
]

# origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    # allow_origins=origins,
    allow_credentials=True,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get('/')
def hello_world2():
    return f'Hello World!'


@app.get('/index')
def hello_world(name: str):
    return f'Hello {name}!'
    # return {"data": f'Hello {name}'}


@app.get('/getpredict')
def getpredict(coors: str):
    predictions = predict(coors)
    return predictions


@app.post('/api/predict')
async def predict_image(item: dict):
    print(item)
    print(type(item))
    return item

# @app.post('/api/predict')
# async def predict_image(item: dict):
#     data = item["data"]
#     predictions = predict(data["coors"])
#     return predictions


@app.post('/api/predictHtml')
async def predict_image(item: dict):
    predictions = predict(item["coors"])
    return predictions

if __name__ == "__main__":
    uvicorn.run(app, port=8080, host='0.0.0.0')
