@echo off
title Powershell Installer
call logo.bat
echo.
echo Installing PowerShell on Windows 7...
echo.

REM Define the download URL for Windows Management Framework 5.1
set "DownloadURL=https://go.microsoft.com/fwlink/?linkid=839516"

REM Define the directory for downloading the installer
set "DownloadDir=%TEMP%\PowerShellInstall"

REM Create the directory for downloading the installer
mkdir "%DownloadDir%"

REM Download the installer
echo Downloading Windows Management Framework 5.1...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('%DownloadURL%', '%DownloadDir%\WMF5.1.msu')"

REM Install the Windows Management Framework 5.1
echo Installing Windows Management Framework 5.1...
"%DownloadDir%\WMF5.1.msu" /quiet /norestart

REM Cleanup
echo Cleaning up...
rmdir /s /q "%DownloadDir%"

echo.
echo Installation completed.
pause
