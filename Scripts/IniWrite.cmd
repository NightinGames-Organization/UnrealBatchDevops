@echo off
@setlocal enableextensions enabledelayedexpansion

set IniFilePath=%~1
set IniArea=[%~2]
set IniNewValue=%~3

call Scripts\GetDirOfFile.cmd %IniFilePath%
set IniFileName=%FileName%.ini

setlocal
set IniFoundArea=
(
    for /f "usebackq delims=" %%a in ("!IniFilePath!") do (
        set "line=%%a"
    
        if !IniFoundArea!==1 (
            echo %IniNewValue%
        )
    
        if /i "!line:~0,1!"=="[" (
            if !line!==%IniArea% (
                set IniFoundArea=1
                echo !line!
            )
            if not !line!==%IniArea% (
                set IniFoundArea=
                echo !line!
            )
        )
    )
)>%IniFilePath%.new

del %IniFilePath%
ren %IniFilePath%.new %IniFileName%
