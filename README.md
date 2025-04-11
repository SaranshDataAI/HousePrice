# 🏠 House Price Prediction Web App

A Flutter Web application that predicts house prices using a Flask API powered by a Random Forest machine learning model.


## 🧠 Tech Stack

### Frontend
- **Flutter Web**: Responsive UI for house price prediction input and results.

### Backend
- **Flask API**: Python-based backend serving predictions from a trained **Random Forest** model.
- **Scikit-learn**: Used for training and predicting with the Random Forest model.

---

## 🚀 Features

- 🌐 Web-based user interface
- 🔌 Real-time predictions through a connected Flask API
- 🧪 Random Forest ML model trained on historical house data
- 📈 Easy-to-use interface for non-technical users

---

## 📂 Project Structure

project-root/ │ ├── flutter_frontend/ │ ├── lib/ │ ├── web/ │ └── ... │ ├── flask_api/ │ ├── app.py │ ├── model/ │ │ └── random_forest_model.pkl │ ├── requirements.txt │ └── ...


---

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Python 3.8+](https://www.python.org/)
- [pip](https://pip.pypa.io/en/stable/)

---

## 🔧 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/house-price-flutter-app.git
cd house-price-flutter-app

cd flask_api
python -m venv venv
source venv/bin/activate    # On Windows: venv\Scripts\activate
pip install -r requirements.txt
python app.py


cd flutter_frontend
flutter pub get
flutter run -d chrome

{
  "feature1": 3,
  "feature2": 1200,
  "feature3": 2,
  ...
}
Response:

json
Copy
Edit
{
  "predicted_price": 254000
}

