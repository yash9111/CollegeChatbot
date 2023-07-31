from flask import Flask, request, jsonify
from gradio_client import Client

app = Flask(__name__)

# gradio_model_src = "https://4da9d912b375124202.gradio.live/"
gradio_model_src = "http://127.0.0.1:7860/"

client = Client(src=gradio_model_src)

@app.after_request
def add_cors_headers(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    return response

@app.route('/predict', methods=['POST', 'OPTIONS'])
def predict():
    if request.method == 'OPTIONS':
        return '', 200

    data = request.json
    text = data['text']

    result = client.predict(text, api_name='/predict')

    return jsonify({'result': result})

if __name__ == '__main__':
    app.run()
