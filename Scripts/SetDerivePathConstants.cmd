@echo off

:: Save the current directory path
set "CurrentDirectory=%cd%"

:: Get command line parameters

call "Scripts/ResolveRelativePath.cmd" "%cd%\%~1"
set "ProjectPath=%AbsPath%"

call "Scripts/ResolveRelativePath.cmd" "%cd%\%~2"
set "OutputDirectory=%AbsPath%"

set "EngineVersion=%~3"

call "Scripts/ResolveRelativePath.cmd" "%~4"
set "SteamSdkDir=%AbsPath%"

set "BinaryConfiguration=%~5"

set "ReleaseName=%~6"

:: Check if the command line parameters were provided
if "%ProjectPath%"=="" (
    echo "Error: ProjectPath not specified."
    echo "Usage: BuildProject.cmd ^<ProjectPath^> ^<OutputDirectory^> ^<EngineVersion^>"
    exit /b 1
)
if "%OutputDirectory%"=="" (
    echo "Error: OutputDirectory not specified."
    echo "Usage: SetDirectories.cmd ^<ProjectPath^> ^<OutputDirectory^> ^<EngineVersion^>"
    exit /b 1
)
if "%EngineVersion%"=="" (
    echo "Error: EngineVersion not specified."
    echo "Usage: SetDirectories.cmd ^<ProjectPath^> ^<OutputDirectory^> ^<EngineVersion^>"
    exit /b 1
)


:: Derive constants

call "Scripts/GetDirOfFile.cmd" "%ProjectPath%"
set "ProjectRoot=%FileDir%"
set "ProjectName=%FileName%"

set "PackageDirGenWin=%OutputDirectory%\Windows"
set "PackageDir=%OutputDirectory%\%ReleaseName%"

set "TargetGame=%ProjectName%"
set "TargetEditor="%ProjectName%Editor"

call Scripts\FetchUnrealEnginePath.cmd "%EngineVersion%"
set "UBTPath=%UnrealEnginePath%\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"
set "UATPath=%UnrealEnginePath%\Engine\Build\BatchFiles\RunUAT.bat"

set "SteamContentBuilderDir=%SteamSdkDir%\sdk\tools\ContentBuilder"
set "SteamContentDir=%SteamContentBuilderDir%\content"
set "SteamCmdPath=%SteamContentBuilderDir%\builder\steamcmd.exe"
set "SteamVdf=%CurrentDirectory%\SteamVDFs\app_build_1000.vdf"

:: Log results
echo "---- SetDerivePathConstants.cmd START ----"
echo "Current Directory = %CurrentDirectory%"
echo "Project Path = %ProjectPath%"
echo "Project Root = %ProjectRoot%"
echo "Project Name = %ProjectName%"
echo "Packaged Project Dir (Generated, Windows) = %PackageDirGenWin%"
echo "Packaged Project Dir = %PackageDir%"
echo "Target Game = %TargetGame%"
echo "Target Editor = %TargetEditor%"
echo "Output Directory = %OutputDirectory%"
echo "Unreal Version = %EngineVersion%"
echo "Unreal Path = %UnrealEnginePath%"
echo "Unreal Build Tool Path = %UBTPath%"
echo "Unreal Automation Tool Path = %UATPath%"
echo "Binary Configuration = %BinaryConfiguration%"
echo "Release Name = %ReleaseName%"
echo "Steam SDK Directory = %SteamSdkDir%"
echo "Steam Command Line Path = %SteamCmdPath%"
echo "---- SetDerivePathConstants.cmd END ----"
echo ""
