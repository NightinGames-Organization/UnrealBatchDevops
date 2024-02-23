import os
import sys
import pickle
import google.auth
import googleapiclient
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

file_path = sys.argv[1]
folder_id = "1Jniw3hJYirlleCZ2R8l54IyrbVYtXAFq"

# Set up authentication and authorization
SCOPES = ['https://www.googleapis.com/auth/drive.file']

creds = None
if os.path.exists('token.pickle'):
    with open('token.pickle', 'rb') as token:
        creds = pickle.load(token)

if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
        creds.refresh(Request())
    else:
        flow = InstalledAppFlow.from_client_secrets_file(
            'Config\Credentials.json', SCOPES)
        creds = flow.run_local_server(port=0)

    with open('token.pickle', 'wb') as token:
        pickle.dump(creds, token)

# Create Google Drive service

drive_service = build('drive', 'v3', credentials=creds)

# Upload file

file_metadata = {
    'name': os.path.basename(file_path), 'parents': [folder_id]
}
media = googleapiclient.http.MediaFileUpload(file_path, resumable=True)
uploaded_file = drive_service.files().create(
    body=file_metadata,
    media_body=media,
    fields='id'
).execute()

print(f"File uploaded with ID: {uploaded_file['id']}")