@echo off
echo =======================================
echo  Downloading AutoIt Decompiler Tools
echo =======================================
echo.
if not exist "D:\EvonyToolKit\tools\decompiled" mkdir "D:\EvonyToolKit\tools\decompiled"
echo Downloading Exe2Aut...
curl -L -o "D:\EvonyToolKit\tools\Exe2Aut.exe" "https://github.com/Wikipedia2008/Exe2Aut/releases/download/0.10.0.2/Exe2Aut.exe"
if exist "D:\EvonyToolKit\tools\Exe2Aut.exe" (
    echo Download successful!
    echo To decompile: D:\EvonyToolKit\tools\Exe2Aut.exe D:\EvonyToolKit\ETK.exe
) else (
    echo Download failed. Get manually from: https://github.com/Wikipedia2008/Exe2Aut/releases
)
pause
