@echo off
title IP Geolocator Needed Files Downloader
if exist logo.bat call logo.bat & echo.
echo Downloading needed files..
echo ==========================
if not exist Newtonsoft.Json.Dll echo Downloading Newtonsoft.Json..
if not exist Newtonsoft.Json.Dll powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://schooicodes.github.io/file_hosting/Newtonsoft.Json.dll -outfile Newtonsoft.Json.Dll"
echo Done.
start "" IPGeolocator.exe
pause
exit