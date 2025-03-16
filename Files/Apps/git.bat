@echo off
title git Installer
if exist logo.bat call logo.bat & echo. 
echo git Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id git.git
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.1/Git-2.41.0-64-bit.exe -OutFile '%TEMP%\gitinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\gitinstaller.exe"
echo Done!
del "%TEMP%\gitinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit