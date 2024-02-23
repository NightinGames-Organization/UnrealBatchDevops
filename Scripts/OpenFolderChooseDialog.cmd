@echo off

set "psCommand="(new-object -COM 'Shell.Application')^.BrowseForFolder(0,'%~1',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "OutputFolder=%%I"

echo %OutputFolder%