@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Blip Installer 
echo Blip Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://get.microsoft.com/installer/download/9N7JSXC1SJK6"' -OutFile '%TEMP%\blipinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\blipinstaller.exe" 
echo Done! 
del "%TEMP%\blipinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
