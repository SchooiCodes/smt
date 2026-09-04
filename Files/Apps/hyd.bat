@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Hydra Launcher Installer 
echo Hydra Launcher Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/hydralauncher/hydra-installer/releases/download/v1.0.0/hydra-installer.exe"' -OutFile '%TEMP%\hydinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\hydinstaller.exe" 
echo Done! 
del "%TEMP%\hydinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
