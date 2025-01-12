@echo off
title IP Geolocator Needed Files Downloader
if exist logo.bat call logo.bat & echo.
echo Downloading needed files..
echo ==========================
if not exist Newtonsoft.Json.Dll echo Downloading Newtonsoft.Json..
if not exist Newtonsoft.Json.Dll powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://schooicodes.github.io/file_hosting/Newtonsoft.Json.dll -outfile Newtonsoft.Json.Dll" & echo Done.
if not exist IPGeolocator.exe echo Downloading IPGeolocator.exe..
if not exist IPGeolocator.exe powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://schooicodes.github.io/file_hosting/IPGeolocator.exe -outfile IPGeolocator.exe" & echo Done.
start "" IPGeolocator.exe
echo Press any key to clean up..
pause >nul
del Newtonsoft.Json.Dll >nul
del IPGeolocator.exe >nul
exit