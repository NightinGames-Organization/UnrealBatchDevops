@echo OFF

set KEY_NAME="HKEY_LOCAL_MACHINE\Software\EpicGames\Unreal Engine\%~1"
set VALUE_NAME="InstalledDirectory"

reg add %KEY_NAME% /v %VALUE_NAME% /d "%~2"