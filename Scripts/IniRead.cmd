@echo off
@setlocal enableextensions enabledelayedexpansion

set IniFile=%~1
set IniArea=[%~2]
set IniFoundArea=

for /f "usebackq delims=" %%a in ("%IniFile%") do (
    set "line=%%a"

    if !IniFoundArea!==1 (
        set IniValue=%%a
        set %3=%%a
    )

    if /i "!line:~0,1!"=="[" (
        if     !line!==%IniArea% set IniFoundArea=1
        if not !line!==%IniArea% set IniFoundArea=
    )
)
echo !IniValue!