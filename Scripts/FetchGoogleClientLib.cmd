@echo off

echo "---- FetchGoogleClientLib.cmd START ----"
python -m pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
python -m pip install --upgrade oauth2client
echo "---- FetchGoogleClientLib.cmd END ----"