@echo off
title winget Installer
if exist logo.bat call logo.bat & echo. 
echo winget Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://aka.ms/getwinget -OutFile '%TEMP%\wginstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\wginstaller.exe"
echo Done!
del "%TEMP%\wginstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit