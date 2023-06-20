import numpy as np
import pandas as pd
from sklearn.preprocessing import MinMaxScaler
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense

# Code to connect to Firestore and retrieve data
# Replace YOUR_FIRESTORE_CREDENTIALS with your actual Firestore credentials
import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(r"C:\Users\Abhijith C\Apps\Electrify\electrify-5ae88-firebase-adminsdk-spnrb-56328eb6ad.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# Retrieve the 'bulb_data' collection
collection_ref = db.collection('bulb_data')
docs = collection_ref.stream()

# Store the data in a pandas DataFrame
data = []
for doc in docs:
    data.append(doc.to_dict())

df = pd.DataFrame(data)

# Extract the energy consumption data for bulb1 and bulb2
bulb1_energy = df['bulb1_energy'].values.astype(float)
bulb2_energy = df['bulb2_energy'].values.astype(float)

# Combine the two bulb energies into a single variable
total_energy = bulb1_energy + bulb2_energy

# Normalize the data
scaler = MinMaxScaler(feature_range=(0, 1))
total_energy_scaled = scaler.fit_transform(total_energy.reshape(-1, 1))

# Prepare the input sequences
window_size = 24  # Number of hours in a day
X = []
y = []
for i in range(len(total_energy_scaled) - window_size):
    X.append(total_energy_scaled[i:i + window_size])
    y.append(total_energy_scaled[i + window_size])

X = np.array(X)
y = np.array(y)

# Reshape the input data for LSTM (samples, time steps, features)
X = np.reshape(X, (X.shape[0], X.shape[1], 1))

# Build the LSTM model
model = Sequential()
model.add(LSTM(units=50, return_sequences=True, input_shape=(X.shape[1], 1)))
model.add(LSTM(units=50))
model.add(Dense(units=1))

model.compile(optimizer='adam', loss='mean_squared_error')

# Train the LSTM model
model.fit(X, y, epochs=100, batch_size=32)

# Prepare the input for predicting the next month
last_month_data = total_energy_scaled[-window_size:]
X_pred = np.array([last_month_data])
X_pred = np.reshape(X_pred, (X_pred.shape[0], X_pred.shape[1], 1))

# Generate predictions for the next month
predicted_scaled = model.predict(X_pred)
predicted = scaler.inverse_transform(predicted_scaled)

# Total energy consumption for the next month
total_energy_predicted = np.sum(predicted)
print("Predicted total energy consumption for the next month:", total_energy_predicted)
