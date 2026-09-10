@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Windhawk Installer 
echo Windhawk Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id RamenSoftware.Windhawk 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/ramensoftware/windhawk/releases/download/v1.7.3/windhawk_setup.exe"' -OutFile '%TEMP%\whkinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\whkinstaller.exe" 
echo Done! 
del "%TEMP%\whkinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
