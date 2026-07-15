@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Playit.gg Installer 
echo Playit.gg Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id DevelopedMethods.playit 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/playit-cloud/playit-agent/releases/download/v1.0.10/playit-windows-x86_64-signed.msi"' -OutFile '%TEMP%\pltinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\pltinstaller.exe" 
echo Done! 
del "%TEMP%\pltinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
