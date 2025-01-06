@echo off
title Telegram Installer
if exist logo.bat call logo.bat & echo. 
echo Telegram Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irm https://telegram.org/dl/desktop/win64 -OutFile '%TEMP%\teleinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\teleinstaller.exe"
echo Done!
pause >nul
exit