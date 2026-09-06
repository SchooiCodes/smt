@echo off
title winget Installer
if exist logo.bat call logo.bat & echo. 
echo winget Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://aka.ms/getwinget -OutFile '%TEMP%\wginstaller.msixbundle'"
echo Installing..
start /WAIT "" "%TEMP%\wginstaller.msixbundle"
echo Done!
del "%TEMP%\wginstaller.msixbundle" >nul
timeout /t 5 /NOBREAK >nul
exit