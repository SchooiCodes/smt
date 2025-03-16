@echo off
title f.lux Installer
if exist logo.bat call logo.bat & echo. 
echo f.lux Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id f.lux.f.lux
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://justgetflux.com/flux-setup.exe -OutFile '%TEMP%\fluxinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\fluxinstaller.exe"
echo Done!
del "%TEMP%\fluxinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit
