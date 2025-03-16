@echo off
title SuperF4 Installer
if exist logo.bat call logo.bat & echo. 
echo SuperF4 Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id StefanSundin.Superf4
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://schooicodes.github.io/file_hosting/SuperF4.exe -OutFile '%TEMP%\sf4installer.exe'"
echo Installing..
start /WAIT "" "%TEMP%\sf4installer.exe"
echo Done!
del "%TEMP%\sf4installer.exe" >nul
timeout /t 5 /NOBREAK >nul
exit
