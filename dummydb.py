import random
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from datetime import datetime, timedelta

# Initialize Firebase credentials and Firestore client
cred = credentials.Certificate(r"C:\Users\Abhijith C\Apps\Electrify\electrify-5ae88-firebase-adminsdk-spnrb-56328eb6ad.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# Delete existing bulb data collection
def delete_bulb_data_collection():
    bulb_data_ref = db.collection('bulb_data')
    docs = bulb_data_ref.stream()
    for doc in docs:
        doc.reference.delete()

# Define function to generate random values and upload to Firestore
def upload_random_values(date, time, day_of_week):
    # Generate random energy consumed values for two bulbs
    bulb1_energy = round(random.uniform(0.1, 10), 2)
    bulb2_energy = round(random.uniform(0.1, 10), 2)

    # Create dictionary of data to upload to Firestore
    data = {
        'bulb1_energy': bulb1_energy,
        'bulb2_energy': bulb2_energy,
        'timestamp': f"{date} {time}",
        'day_of_week': day_of_week
    }

    # Upload data to Firestore
    doc_ref = db.collection('bulb_data').document(f"{date} {time}")
    doc_ref.set(data)

# Delete existing bulb data collection
delete_bulb_data_collection()

# Generate data for 30 days
start_date = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
for day in range(30):
    current_date = start_date + timedelta(days=day)
    for hour in range(24):
        current_time = current_date.replace(hour=hour)
        day_of_week = current_time.strftime("%A")
        upload_random_values(current_date.strftime("%Y-%m-%d"), current_time.strftime("%H:%M:%S"), day_of_week)

print("Data generation and upload complete.")
