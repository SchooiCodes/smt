@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title ExifCleaner Installer 
echo ExifCleaner Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id szTheory.exifcleaner 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/szTheory/exifcleaner/releases/download/v4.2.1/ExifCleaner.Setup.4.2.1.exe"' -OutFile '%TEMP%\exfinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\exfinstaller.exe" 
echo Done! 
del "%TEMP%\exfinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
