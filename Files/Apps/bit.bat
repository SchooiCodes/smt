@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Bitdefender Free Installer 
echo Bitdefender Free Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://download.bitdefender.com/windows/installer/en-us/bitdefender_avfree.exe"' -OutFile '%TEMP%\bitinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\bitinstaller.exe" 
echo Done! 
del "%TEMP%\bitinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
