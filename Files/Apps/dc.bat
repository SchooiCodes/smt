@echo off
title Discord Installer
if exist logo.bat call logo.bat & echo. 
echo Discord Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install -e --accept-package-agreements --force --id Discord.Discord
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86 -OutFile '%TEMP%\dcinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\dcinstaller.exe"
echo Done!
del "%TEMP%\dcinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit