@echo off
title ShareX Installer
if exist logo.bat call logo.bat & echo. 
echo ShareX Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/ShareX/ShareX/releases/download/v17.0.0/ShareX-17.0.0-setup.exe -OutFile '%TEMP%\shxinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\shxinstaller.exe"
echo Done!
del "%TEMP%\shxinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit