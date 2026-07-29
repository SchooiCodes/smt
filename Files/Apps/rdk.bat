@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title RustDesk Installer 
echo RustDesk Installer 
echo ================== 
echo Package does not exist on winget! Using irm to download the installer and installing manually.. 
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/rustdesk/rustdesk/releases/download/1.4.9/rustdesk-1.4.9-x86_64.exe"' -OutFile '%TEMP%\rdkinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\rdkinstaller.exe" 
echo Done! 
del "%TEMP%\rdkinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
