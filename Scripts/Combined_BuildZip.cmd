@echo off

call "Scripts\SetDerivePathConstants.cmd" "%~1" "%~2" "%~3" "%~4" "%~5"
call "Scripts\SetSecrets"

call "Scripts\PackageUnrealProject.cmd"

echo "Rename generated package directory and exe..."
ren "%PackageDirGenWin%" "%ReleaseName%"
ren "%OutputDirectory%\%ReleaseName%\%ProjectName%.exe" "%ReleaseName%.exe"

echo "Zipping package directory..."
set "FilesToZip=%PackageDir%\*"
set "ZipPath=%OutputDirectory%\%ReleaseName%.zip"
call "Scripts\Zip.cmd"