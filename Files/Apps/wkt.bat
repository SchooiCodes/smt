@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title WakaTime Installer 
echo WakaTime Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/wakatime/desktop-wakatime/releases/latest/download/wakatime-win32-x64.exe"' -OutFile '%TEMP%\wktinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\wktinstaller.exe" 
echo Done! 
del "%TEMP%\wktinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
