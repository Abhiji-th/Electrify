import random
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Initialize Firebase credentials and Firestore client
cred = credentials.Certificate(r"C:\Users\Abhijith C\Apps\Electrify\electrify-5ae88-firebase-adminsdk-spnrb-56328eb6ad.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# Define function to generate random values and upload to Firestore
def upload_random_values():
    # Generate random VRMS and IRMS values for two bulbs
    bulb1_vrms = round(random.uniform(220, 240), 2)
    bulb1_irms = round(random.uniform(0.01, 0.02), 4)
    bulb2_vrms = round(random.uniform(220, 240), 2)
    bulb2_irms = round(random.uniform(0.01, 0.02), 4)

    # Create dictionary of data to upload to Firestore
    data = {
        'bulb1_vrms': bulb1_vrms,
        'bulb1_irms': bulb1_irms,
        'bulb2_vrms': bulb2_vrms,
        'bulb2_irms': bulb2_irms
    }

    # Upload data to Firestore
    doc_ref = db.collection('bulb_data').document()
    doc_ref.set(data)

# Upload random values to Firestore every minute, stopping after 1440 entries
counter = 0
while counter < 1440:
    upload_random_values()
    counter += 1
    #time.sleep(60)  # Wait for a minute before uploading again
