@echo off
title ShareX Installer
if exist logo.bat call logo.bat & echo. 
echo ShareX Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id ShareX.ShareX
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/ShareX/ShareX/releases/download/v17.0.0/ShareX-17.0.0-setup.exe -OutFile '%TEMP%\shxinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\shxinstaller.exe"
echo Done!
del "%TEMP%\shxinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit