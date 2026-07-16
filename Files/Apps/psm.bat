@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Prism Launcher Installer 
echo Prism Launcher Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id PrismLauncher.PrismLauncher 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/PrismLauncher/PrismLauncher/releases/download/11.0.3/PrismLauncher-Windows-MSVC-Setup-11.0.3.exe"' -OutFile '%TEMP%\psminstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\psminstaller.exe" 
echo Done! 
del "%TEMP%\psminstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
