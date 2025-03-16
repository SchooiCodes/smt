@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Notepad++ Installer 
echo Notepad++ Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Notepad++.Notepad++ 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7.5/npp.8.7.5.Installer.exe"' -OutFile '%TEMP%\nppinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\nppinstaller.exe" 
echo Done! 
del "%TEMP%\nppinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
