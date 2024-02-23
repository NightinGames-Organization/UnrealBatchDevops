@echo OFF

set KEY_NAME="HKEY_LOCAL_MACHINE\Software\EpicGames\Unreal Engine\%~1"
set VALUE_NAME="InstalledDirectory"

for /f "tokens=2* skip=2" %%a in ('reg query %KEY_NAME% /v %VALUE_NAME%') do set UnrealEnginePath=%%b