@echo off
title Notepad++ Installer
if exist logo.bat call logo.bat & echo. 
echo Notepad++ Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7.5/npp.8.7.5.Installer.exe -OutFile '%TEMP%\nppinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\nppinstaller.exe"
echo Done!
del "%TEMP%\nppinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit