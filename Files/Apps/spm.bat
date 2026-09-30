@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Supermium Installer 
echo Supermium Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://download.win32subsystem.live/supermium/releases/v144-r5/supermium_144_32_setup.exe"' -OutFile '%TEMP%\spminstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\spminstaller.exe" 
echo Done! 
del "%TEMP%\spminstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
