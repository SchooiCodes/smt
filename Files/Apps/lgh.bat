@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Logitech G HUB Installer 
echo Logitech G HUB Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Logitech.GHUB 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe"' -OutFile '%TEMP%\lghinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\lghinstaller.exe" 
echo Done! 
del "%TEMP%\lghinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
