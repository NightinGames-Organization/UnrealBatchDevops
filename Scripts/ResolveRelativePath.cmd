@echo off

:: Temporarily change the current working directory, to retrieve a full path 
:: to the first parameter
pushd .
cd %~dp0
set "AbsPath=%~f1"
popd