@echo off
cd /d "%~dp0"
title Scoop Installer
if exist logo.bat call logo.bat & echo.
echo Scoop Installer
echo ===============
echo PLEASE TURN OFF REAL TIME PROTECTION IN YOUR ANTIVIRUS.
echo After that, press any key here to start the installation.
pause >nul
echo Installing scoop..
powershell Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
powershell -Command "Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
echo Script finished.
timeout /t 5 >nul
exit