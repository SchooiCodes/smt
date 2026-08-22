@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title pnpm Installer 
echo pnpm Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id pnpm.pnpm 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/pnpm/pnpm/releases/download/v11.22.0/pnpm-win32-x64.zip"' -OutFile '%TEMP%\pnpminstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\pnpminstaller.exe" 
echo Done! 
del "%TEMP%\pnpminstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
