@echo off
title Malwarebytes Installer
if exist logo.bat call logo.bat & echo. 
echo Malwarebytes Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://data-cdn.mbamupdates.com/web/mb5-setup-consumer/MBSetup.exe -OutFile '%TEMP%\mbaminstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\mbaminstaller.exe"
echo Done!
del "%TEMP%\mbaminstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit