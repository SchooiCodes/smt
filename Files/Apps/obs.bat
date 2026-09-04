@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title OBS Studio Installer 
echo OBS Studio Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id OBSProject.OBSStudio 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/obsproject/obs-studio/releases/download/32.2.1/OBS-Studio-32.2.1-Windows-x64-Installer.exe"' -OutFile '%TEMP%\obsinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\obsinstaller.exe" 
echo Done! 
del "%TEMP%\obsinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
