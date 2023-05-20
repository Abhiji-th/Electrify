import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score

# Initialize Firebase credentials and database
cred = credentials.Certificate(r"C:\Users\aiswa\majpro\Electrify\electrify-5ae88-firebase-adminsdk-spnrb-14100cd315.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://electrify-5ae88-default-rtdb.firebaseio.com/'
})

# Retrieve dataset from Firebase Realtime Database
ref = db.reference('light_bulbs')
dataset = ref.get()

# Convert dataset to pandas DataFrame
data = []
for key, value in dataset.items():
    data.append(value)
df = pd.DataFrame(data)

# Prepare data for linear regression
features = df[['bulb1_status', 'bulb2_status']]
target = df['energy_consumption']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)

# Create a Linear Regression model
model = LinearRegression()

# Fit the model to the training data
model.fit(X_train, y_train)

# Make predictions on the testing data
y_pred = model.predict(X_test)

# Evaluate the model
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

# Print evaluation metrics
print("Mean Squared Error:", mse)
print("R-squared:", r2)
