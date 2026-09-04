@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Audacity Installer 
echo Audacity Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Audacity.Audacity 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/audacity/audacity/releases/download/Audacity-4.0.0/audacity-win-4.0.0-x86_64.msi"' -OutFile '%TEMP%\audinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\audinstaller.exe" 
echo Done! 
del "%TEMP%\audinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
