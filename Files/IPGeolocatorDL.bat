@echo off
title IP Geolocator Needed Files Downloader
call logo.bat
echo.
echo Downloading needed files..
echo ==========================
if not exist Newtonsoft.Json.Dll echo Downloading Newtonsoft.Json..
if not exist Newtonsoft.Json.Dll powershell -Command "irm https://schooicodes.github.io/file_hosting/Newtonsoft.Json.dll -outfile Newtonsoft.Json.Dll"
echo Done.
start "" IPGeolocator.exe
pause
exit