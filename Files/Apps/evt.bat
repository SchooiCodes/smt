@echo off
title Everything Installer
if exist logo.bat call logo.bat & echo. 
echo Everything Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://www.voidtools.com/Everything-1.4.1.1026.x86-Setup.exe -OutFile '%TEMP%\evtinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\evtinstaller.exe"
echo Done!
del "%TEMP%\evtinstaller.exe" >nul
pause >nul
exit