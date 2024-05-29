@echo off
call logo.bat
title BlockTheSpot Installer
echo.
echo BlockTheSpot (Spotify without ads)  Installer
powershell.exe -executionpolicy remotesigned -File flux.ps1
echo Done.
pause >nul
exit