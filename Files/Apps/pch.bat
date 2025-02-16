@echo off
title Process Hacker Installer
if exist logo.bat call logo.bat & echo. 
echo Process Hacker Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://unlimited.dl.sourceforge.net/project/processhacker/processhacker2/processhacker-2.39-setup.exe?viasf=1 -OutFile '%TEMP%\pchinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\pchinstaller.exe"
echo Done!
del "%TEMP%\pchinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit