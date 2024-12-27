@echo off
if exist logo.bat call logo.bat & echo.
title Downloading rockyou.txt...
set /p DownloadDir=Where would you like to save rockyou.txt? (Type a dot and hit enter to download it here) ^| ^> 
if NOT exist "%DownloadDir%" mkdir "%DownloadDir%"
echo Downloading rockyou.txt
powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irm -useb https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -OutFile '%DownloadDir%\rockyou.txt'"
echo Operation Succeeded
pause >nul
exit
