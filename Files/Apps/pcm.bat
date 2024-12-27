@echo off
title Windows PC Manager Installer
if exist logo.bat call logo.bat & echo.
echo Windows PC Manager Installer
echo =============================
echo Downloading..
powershell -Command "Invoke-WebRequest -Uri 'https://schooicodes.github.io/file_hosting/PCManager.msix' -OutFile '%USERPROFILE%\Downloads\PCManagerSetup.msix'"
echo Installing..
"%USERPROFILE%\Downloads\PCManagerSetup.msix"
pause >nul
echo Cleaning up..
del "%USERPROFILE%\Downloads\PCManagerSetup.msix"
exit