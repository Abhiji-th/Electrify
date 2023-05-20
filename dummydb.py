import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import random
import datetime

# Initialize Firebase credentials and database
cred = credentials.Certificate(r"C:\Users\aiswa\majpro\Electrify\electrify-5ae88-firebase-adminsdk-spnrb-14100cd315.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://electrify-5ae88-default-rtdb.firebaseio.com/'
})

# Generate and upload dataset
def generate_and_upload_dataset(num_entries):
    # Get a reference to the database
    ref = db.reference('light_bulbs')

    for i in range(num_entries):
        # Generate random on/off status and energy consumption for light bulbs
        bulb1_status = random.choice([True, False])
        bulb2_status = random.choice([True, False])
        energy_consumption = random.uniform(0.1, 0.5)  # Random energy consumption between 0.1 and 0.5 kWh

        # Create a timestamp for the entry
        timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        # Create a dictionary object for the data entry
        data = {
            'bulb1_status': bulb1_status,
            'bulb2_status': bulb2_status,
            'energy_consumption': energy_consumption,
            'timestamp': timestamp
        }

        # Push the data entry to the Firebase database
        ref.push(data)

    print(f'{num_entries} dataset entries uploaded to Firebase.')


# Usage
generate_and_upload_dataset(100)  # Upload 100 dataset entries
