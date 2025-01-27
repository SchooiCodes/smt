@echo off
title Github Desktop Installer
if exist logo.bat call logo.bat & echo. 
echo Github Desktop Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://central.github.com/deployments/desktop/desktop/latest/win32 -OutFile '%TEMP%\gitdinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\gitdinstaller.exe"
echo Done!
del "%TEMP%\gitdinstaller.exe" >nul
pause >nul
exit