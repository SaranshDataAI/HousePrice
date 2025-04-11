from flask import Flask, request, jsonify
from flask_cors import CORS  # ✅ Add this
import joblib
import pandas as pd

app = Flask(__name__)
CORS(app)  # ✅ This enables CORS for all routes

# Load model
model = joblib.load("price_predictor_rf.pkl")

@app.route('/')
def home():
    return "Price Prediction API is up!"

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    input_df = pd.DataFrame([data])
    prediction = model.predict(input_df)[0]
    return jsonify({"predicted_price": round(prediction)})

if __name__ == '__main__':
    app.run(debug=True)
