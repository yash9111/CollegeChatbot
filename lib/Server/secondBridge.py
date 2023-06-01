from flask import Flask, request, jsonify
from gradio_client import Client

app = Flask(__name__)

# Define the Gradio model source
# gradio_model_src = "https://4da9d912b375124202.gradio.live/"
gradio_model_src = "http://127.0.0.1:7860/"

# Initialize the Gradio client
client = Client(src=gradio_model_src)

# Enable CORS
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

    # Retrieve the input text from the request
    data = request.json
    text = data['text']

    # Perform the prediction using gradio_client.Client
    result = client.predict(text, api_name='/predict')

    # Return the prediction result as a JSON response
    return jsonify({'result': result})

if __name__ == '__main__':
    app.run()
