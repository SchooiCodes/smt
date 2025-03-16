@echo off
title Github Desktop Installer
if exist logo.bat call logo.bat & echo. 
echo Github Desktop Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id GitHub.GitHubDesktop
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://central.github.com/deployments/desktop/desktop/latest/win32 -OutFile '%TEMP%\gitdinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\gitdinstaller.exe"
echo Done!
del "%TEMP%\gitdinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit