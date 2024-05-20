@echo off
title Winget Installer
echo Winget Installer
echo ================
echo.
Powershell.exe -executionpolicy remotesigned -File winget.ps1
pause >nul
exit