@echo off

:: https://stackoverflow.com/a/75978661

setlocal EnableDelayedExpansion

echo "---- FetchPython.cmd START ----"

set url=https://endoflife.date/api/python.json

set "response="
for /f "usebackq delims=" %%i in (`powershell -command "& {(Invoke-WebRequest -Uri '%url%' -UseBasicParsing).Content}"`) do set "response=!response!%%i"

set "latest_py_version="
for /f "tokens=1,2 delims=}" %%a in ("%response%") do (
    set "object=%%a}"
    for %%x in (!object!) do (
        for /f "tokens=1,* delims=:" %%y in ("%%x") do (
            if "%%~y" == "latest" (
                set "latest_py_version=%%~z"
            )
        )
    )
)

echo Latest Python version is: %latest_py_version%

REM Set the minimum required Python version
set python_version=%latest_py_version%

REM Check if Python is already installed and if the version is less than python_version
echo Checking if Python %python_version% or greater is already installed...
set "current_version="
where python >nul 2>nul && (
    for /f "tokens=2" %%v in ('python --version 2^>^&1') do set "current_version=%%v"
)
if "%current_version%"=="" (
    echo Python is not installed. Proceeding with installation.
) else (
    if "%current_version%" geq "%python_version%" (
        echo Python %python_version% or greater is already installed. Exiting.
        goto done
    )
)

REM Define the URL and file name of the Python installer
set "url=https://www.python.org/ftp/python/%python_version%/python-%python_version%-amd64.exe"
set "installer=python-%python_version%-amd64.exe"

REM Define the installation directory
set "targetdir=C:\Python%python_version%"

REM Download the Python installer
echo Downloading Python installer...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%url%', '%installer%')"

REM Install Python with a spinner animation
echo Installing Python...
start /wait %installer% /quiet /passive TargetDir=%targetdir% Include_test=0 ^
&& (echo Done.) || (echo Failed!)
echo.

REM Add Python to the system PATH
echo Adding Python to the system PATH...
setx PATH "%targetdir%;%PATH%"
if %errorlevel% EQU 1 (
  echo Python has been successfully installed to your system BUT failed to set system PATH. Try running the script as administrator.
  pause
  exit
)
echo Python %python_version% has been successfully installed and added to the system PATH.

REM Add Python Scripts dir to the system PATH
echo Adding Python Scripts dir to the system PATH...
setx PATH "%targetdir%\Scripts';%PATH%"
if %errorlevel% EQU 1 (
  echo Failed to add Scripts dir to the system PATH. Try running the script as administrator.
  pause
  exit
)
echo Python Scripts directory has been added to the system PATH.

REM Upgrading pip
echo Upgrading pip...
python -m pip install --upgrade pip

REM Cleanup
echo Cleaning up...
del %installer%

echo Done!

:done
echo "---- FetchPython.cmd END ----"