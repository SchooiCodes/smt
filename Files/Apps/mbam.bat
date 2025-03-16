@echo off
title Malwarebytes Installer
if exist logo.bat call logo.bat & echo. 
echo Malwarebytes Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Malwarebytes.Malwarebytes
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://data-cdn.mbamupdates.com/web/mb5-setup-consumer/MBSetup.exe -OutFile '%TEMP%\mbaminstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\mbaminstaller.exe"
echo Done!
del "%TEMP%\mbaminstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit