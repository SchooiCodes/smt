@echo off
title Recuva Installer
if exist logo.bat call logo.bat & echo. 
echo Recuva Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Piriform.Recuva
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://download.ccleaner.com/rcsetup154.exe -OutFile '%TEMP%\rcvinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\rcvinstaller.exe"
echo Done!
del "%TEMP%\rcvinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit