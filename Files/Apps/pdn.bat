@echo off
title Paint.NET Installer
if exist logo.bat call logo.bat & echo. 
echo Paint.NET Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id dotPDNLLC.paintdotnet
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/paintdotnet/release/releases/download/v5.1.2/paint.net.5.1.2.install.anycpu.web.zip -OutFile '%TEMP%\pdninstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\pdninstaller.exe"
echo Done!
del "%TEMP%\pdninstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit