import random
import time
import math
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Fetch the service account key JSON file and initialize Firebase Admin SDK
cred = credentials.Certificate(r"C:\Users\Abhijith C\Apps\Electrify\electrify-5ae88-firebase-adminsdk-spnrb-56328eb6ad.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://electrify-5ae88-default-rtdb.firebaseio.com/Devices'
})

# Get a reference to the root of your Firebase Realtime Database
root_ref = db.reference('/')

bulb1_totalenergy = 0
bulb2_totalenergy = 0
total_energy = 0

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
    root_ref.update(data)

    # Wait for 5 seconds before generating and uploading the next set of values
    # time.sleep(1)



