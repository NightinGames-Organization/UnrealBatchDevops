@echo off

for %%i IN ("%~1") DO (
	set "FileDrive=%%~di"
	set "FilePath=%%~pi"
	set "FileName=%%~ni"
	set "FileExtension=%%~xi"
)
set "FileDir=%FileDrive%%FilePath%"