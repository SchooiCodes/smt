@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Stacher7 Installer 
echo Stacher7 Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Stacher.Stacher 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://api.stacher.io/api/update/windows/x64/latest"' -OutFile '%TEMP%\st7installer.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\st7installer.exe" 
echo Done! 
del "%TEMP%\st7installer.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
