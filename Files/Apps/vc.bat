@echo off
title Vencord Installer
if exist logo.bat call logo.bat & echo. 
echo Vencord Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/Vencord/Installer/releases/latest/download/VencordInstaller.exe -OutFile '%TEMP%\vcinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\vcinstaller.exe"
echo Done!
del "%TEMP%\vcinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit