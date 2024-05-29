@echo off
call logo.bat
echo.
echo f.lux Installer
echo ================
echo Downloading..
powershell.exe -executionpolicy remotesigned -File flux.ps1