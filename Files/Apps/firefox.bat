@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Firefox Installer 
echo Firefox Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Mozilla.Firefox 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=en-US"' -OutFile '%TEMP%\ffxinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\ffxinstaller.exe" 
echo Done! 
del "%TEMP%\ffxinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
