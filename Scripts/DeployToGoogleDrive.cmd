@echo off

call Scripts\FetchPython.cmd
call Scripts\FetchGoogleClientLib.cmd

python Scripts\UploadFileToGoogleDrive.py "%~1"