@echo off

call "Scripts\SetDerivePathConstants.cmd" "%~1" "%~2" "%~3" "%~4"
call "Scripts\SetSecrets"

set "ZipPath=%OutputDirectory%\%ProjectName%.zip"

::call "Scripts\DeployToGoogleDrive.cmd" %ZipPath%