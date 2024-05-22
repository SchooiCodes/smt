@echo off
call logo.bat
echo.
title Downloading rockyou.txt...
set DownloadURL=https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
set /p DownloadDir=Where would you like to save rockyou.txt? ^| ^> 
if NOT exist "%DownloadDir%" mkdir "%DownloadDir%"
echo Downloading rockyou.txt
powershell -command "(New-Object System.Net.WebClient).DownloadFile('%DownloadURL%', '%DownloadDir%\rockyou.txt')"
echo Operation Succeeded
pause >nul
exit
