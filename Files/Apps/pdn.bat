@echo off
title Paint.NET Installer
if exist logo.bat call logo.bat & echo. 
echo Paint.NET Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/paintdotnet/release/releases/download/v5.1.2/paint.net.5.1.2.install.anycpu.web.zip -OutFile '%TEMP%\pdninstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\pdninstaller.exe"
echo Done!
del "%TEMP%\pdninstaller.exe" >nul
pause >nul
exit