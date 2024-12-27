@echo off
title Firefox Needed File Downloader
call logo.bat
echo.
echo Downloading needed files..
echo ==========================
if not exist firefox_.bat echo Downloading firefox_.bat..
if not exist firefox_.bat powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irm https://schooicodes.github.io/file_hosting/firefox.bat -outfile firefox_.bat"
echo Done.
cls
call firefox_.bat
del firefox_.bat >nul
exit