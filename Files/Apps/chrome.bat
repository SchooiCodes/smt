@echo off
title Chrome Installer
if exist logo.bat call logo.bat & echo. 
echo Chrome Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install -e --accept-package-agreements --force --id Google.Chrome
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm http://dl.google.com/chrome/install/375.126/chrome_installer.exe -OutFile '%TEMP%\chrinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\chrinstaller.exe"
echo Done!
del "%TEMP%\chrinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit