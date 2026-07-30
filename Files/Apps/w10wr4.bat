@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Win10 Widgets + Rainmeter 4.0 Installer 
echo Win10 Widgets + Rainmeter 4.0 Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/tjmarkham/win10widgets/releases/download/1.0.0/Win10-Widgets.Rainmeter-4.0.exe"' -OutFile '%TEMP%\w10wr4installer.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\w10wr4installer.exe" 
echo Done! 
del "%TEMP%\w10wr4installer.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
