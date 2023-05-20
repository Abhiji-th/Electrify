import random
import time
import firebase_admin
import math
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import db
import numpy as np
from sklearn.linear_model import LinearRegression

# Initialize the Firestore database using a service account
cred = credentials.Certificate("C:\Users\aiswa\majpro\Electrify\electrify-5ae88-firebase-adminsdk-spnrb-14100cd315.json")
# firebase_admin.initialize_app(cred)
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://electrify-5ae88-default-rtdb.firebaseio.com/'
})

db_store = firestore.client()

# Fetch IRMS and VRMS values from Firestore collection
collection_ref = db_store.collection('bulb_data')
docs = collection_ref.get()

def calculate_energy(irms, vrms):
    power = irms * vrms
    energy = power / 1000  # Convert from watts to kilowatts (kW)
    return energy

def calculate_bill(units):
    fixed_charges = [35, 55, 70, 100, 110]
    energy_charges = [3.15, 3.95, 5.00, 6.80, 8.00]
    bill = 0

    # Calculate bill based on consumption slab
    if units <= 50:
        bill = fixed_charges[0] + units * energy_charges[0]
    elif units <= 100:
        bill = fixed_charges[1] + (units - 50) * energy_charges[1]
    elif units <= 150:
        bill = fixed_charges[2] + (units - 100) * energy_charges[2]
    elif units <= 200:
        bill = fixed_charges[3] + (units - 150) * energy_charges[3]
    else:
        bill = fixed_charges[4] + (units - 200) * energy_charges[4]

    return bill

# Initialize lists to store minute-level energy consumption for each bulb
bulb1_energy_minutes = []
bulb2_energy_minutes = []

for doc in docs:
    data = doc.to_dict()
    bulb1_irms = data.get('bulb1_irms')
    bulb1_vrms = data.get('bulb1_vrms')
    bulb2_irms = data.get('bulb2_irms')
    bulb2_vrms = data.get('bulb2_vrms')

    # Calculate energy consumption for each bulb
    bulb1_energy = calculate_energy(bulb1_irms, bulb1_vrms)
    bulb2_energy = calculate_energy(bulb2_irms, bulb2_vrms)

    # Append the minute-level energy consumption to the respective lists
    bulb1_energy_minutes.append(bulb1_energy)
    bulb2_energy_minutes.append(bulb2_energy)

# Convert the minute-level energy consumption to numpy arrays
bulb1_energy_minutes = np.array(bulb1_energy_minutes).reshape(-1, 1)
bulb2_energy_minutes = np.array(bulb2_energy_minutes).reshape(-1, 1)

# Create minute intervals for the entire month
num_minutes_in_month = 30 * 24 * 60  # Assuming a 30-day month
X_month = np.arange(num_minutes_in_month).reshape(-1, 1)

# Train separate linear regression models for each bulb
model_bulb1 = LinearRegression()
model_bulb1.fit(np.arange(len(bulb1_energy_minutes)).reshape(-1, 1), bulb1_energy_minutes)

model_bulb2 = LinearRegression()
model_bulb2.fit(np.arange(len(bulb2_energy_minutes)).reshape(-1, 1), bulb2_energy_minutes)

# Predict energy consumption for the entire month for each bulb
predicted_energy_bulb1 = model_bulb1.predict(X_month)
predicted_energy_bulb2 = model_bulb2.predict(X_month)

# Calculate total predicted energy consumption for the month for each bulb
total_energy_bulb1 = np.sum(predicted_energy_bulb1)
total_energy_bulb2 = np.sum(predicted_energy_bulb2)
total_energy = total_energy_bulb1 + total_energy_bulb2

bill = calculate_bill(math.floor(total_energy))

# Print the total predicted energy consumption for the month for each bulb
print(f"Total Predicted Energy Consumption for Bulb 1: {total_energy_bulb1}")
print(f"Total Predicted Energy Consumption for Bulb 2: {total_energy_bulb2}")

# Prepare the data to be uploaded to Firebase
data = {
    'total_energy_bulb1': round(total_energy_bulb1, 4),
    'total_energy_bulb2': round(total_energy_bulb2, 4),
    'total_energy': round(total_energy, 2),
    'bill': bill
}

# Upload the data to Firebase Realtime Database
ref = db.reference('/predicted_energy')
ref.set(data)

# Print a success message
print("Total predicted energy consumption uploaded to Firebase.")

ref = db.reference('/')

bulb1_totalenergy = 0
bulb2_totalenergy = 0
total_energy = 0

# Loop indefinitely to continuously upload random values to the database
while True:
    # Generate random VRMS and IRMS values for two bulbs
    bulb1_vrms = round(random.uniform(220, 240), 2)
    bulb1_irms = round(random.uniform(0.1, 0.2), 4)
    bulb2_vrms = round(random.uniform(220, 240), 2)
    bulb2_irms = round(random.uniform(0.1, 0.2), 4)

    # Calculate the power and energy consumption values for each bulb
    bulb1_power = round(bulb1_vrms * bulb1_irms, 4)
    bulb1_energy = round(bulb1_power * 1 / 3600, 4)
    bulb2_power = round(bulb2_vrms * bulb2_irms, 4)
    bulb2_energy = round(bulb2_power * 1 / 3600, 4)

    bulb1_totalenergy += bulb1_energy
    bulb2_totalenergy +=bulb2_energy

    total_energy += bulb1_energy + bulb2_energy 

    bulb1_unit = math.floor(bulb1_totalenergy)
    bulb2_unit = math.floor(bulb2_totalenergy)
    total_unit = math.floor(total_energy)

    bulb1_totalenergy = round(bulb1_totalenergy, 4)
    bulb2_totalenergy = round(bulb2_totalenergy, 4)
    total_energy = round(total_energy, 4)

    bill = calculate_bill(total_unit)
    bill = round(bill, 2)

    # Create a dictionary of the data to be uploaded to the database
    data = {
        'devices' : {
            'bulb1': {
                'voltage': bulb1_vrms,
                'current': bulb1_irms,
                'power': bulb1_power,
                'energy': bulb1_totalenergy,
                'unit' : bulb1_unit
            },
            'bulb2': {
                'voltage': bulb2_vrms,
                'current': bulb2_irms,
                'power': bulb2_power,
                'energy': bulb2_totalenergy,
                'unit' : bulb2_unit
            },
            'totalEnergy' : total_energy,
            'totalUnit' : total_unit,
            'bill' : bill
        }
    }

    # Upload the data to the database
    ref.update(data)

    # Wait for 5 seconds before generating and uploading the next set of values
    # time.sleep(1)

