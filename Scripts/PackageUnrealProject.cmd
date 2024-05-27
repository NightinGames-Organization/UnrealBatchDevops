@echo off

echo "---- PackageUnrealProject.cmd START ----"

echo "Generate project files using the Unreal Build Tool..."
"%UBTPath%" -projectfiles -project="%ProjectPath%"
echo "UBT Done"
echo ""

quit

echo "Build the project using the Unreal Automation Tool..."
"%UATPath%" BuildCookRun -project="%ProjectPath%" -noP4 -platform=Win64 -clientconfig="%BinaryConfiguration%" -serverconfig="%BinaryConfiguration%" -cook -allmaps -build -stage -pak -archive -archivedirectory="%OutputDirectory%"
echo "UAT Done"
echo ""

echo "---- PackageUnrealProject.cmd END ----"
echo ""