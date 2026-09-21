@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title VS Code Installer 
echo VS Code Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"' -OutFile '%TEMP%\vscinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\vscinstaller.exe" 
echo Done! 
del "%TEMP%\vscinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
