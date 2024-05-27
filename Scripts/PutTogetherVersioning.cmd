@echo off

for /f %%i in ('git -C "../../" describe') do set GitDescribeResult=%%i

for /F "tokens=1,2,3,4 delims=-" %%a in ("%GitDescribeResult%") do set SteamVersioningString=%%a %%b %BinaryConfiguration% %%d

echo %SteamVersioningString%