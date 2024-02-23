@echo off
@setlocal enableextensions enabledelayedexpansion

echo "---- FetchUnrealEngineParentDir.cmd START ----"

set "NightinBuildIni=Config\NightinBuild.ini"

set IniValue=""
set IniVal=

call Scripts\IniRead.cmd %NightinBuildIni% UnrealEngineParentDir IniVal
set UnrealEngineParentDir=!IniValue!

echo "%IniValue%"
echo %IniValue%
echo !IniValue!
echo "%IniVal%"
echo %IniVal%
echo !IniVal!
goto eof

if not exist !UnrealEngineParentDir! (
    echo "Path '!UnrealEngineParentDir!' stored in NightinBuild.ini doesn't exist, trying default installation path."
    set "UnrealEngineParentDir=C:\Program Files\Epic Games\"
)

:userchoose
if not exist !UnrealEngineParentDir! (
    echo "Path '!UnrealEngineParentDir!' doesn't exist, asking user..."
    call Scripts\OpenFolderChooseDialog.cmd "Choose the directory were your Unreal Engine installations are located in!"
    set UnrealEngineParentDir=!OutputFolder!
    echo "User chose path !UnrealEngineParentDir!"
)

if not exist !UnrealEngineParentDir! (
    goto userchoose
)

echo "Found valid path, storing in NightinBuild.ini."
call Scripts\IniWrite.cmd %NightinBuildIni% UnrealEngineParentDir "%UnrealEngineParentDir%"

echo "Unreal Engine Parent Dir = %UnrealEngineParentDir%"
echo "---- FetchUnrealEngineParentDir.cmd END ----"