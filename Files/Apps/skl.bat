@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title SKLauncher Installer 
echo SKLauncher Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/sklauncher/binaries/releases/download/v4.0.36/SKlauncher-4.0.36-web-setup.exe"' -OutFile '%TEMP%\sklinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\sklinstaller.exe" 
echo Done! 
del "%TEMP%\sklinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
