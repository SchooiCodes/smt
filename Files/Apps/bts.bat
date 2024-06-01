@echo off
call logo.bat
title BlockTheSpot Installer
echo.
echo BlockTheSpot (Spotify without ads)  Installer
powershell -Command "irm https://schooicodes.github.io/file_hosting/bts.ps1 | iex"
echo Done.
pause >nul
exit