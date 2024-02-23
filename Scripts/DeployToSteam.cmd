@echo off

echo "---- DeployToSteam.cmd START ----"

echo "Clearing Steam SDK content dir..."
rmdir /S /Q "%SteamContentDir%"
mkdir "%SteamContentDir%"

echo "Copying packaged project to Steam SDK content dir..."
robocopy "%PackageDir%" "%SteamContentDir%" /E

:: echo "Uploading to steam..."
:: call "%SteamCmdPath%" +login %SteamUsername% %SteamPassword% +run_app_build -desc "%GithubSha%" "%SteamVdf%" +quit

echo "---- DeployToSteam.cmd END ----"
