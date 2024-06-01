@echo off
call logo.bat
echo.
title Winget Installer
echo Winget Installer
echo ================
echo.
powershell -Command "irm https://schooicodes.github.io/file_hosting/winget.ps1 | iex"
pause >nul
exit