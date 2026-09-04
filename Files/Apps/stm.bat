@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Steam Installer 
echo Steam Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Valve.Steam 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"' -OutFile '%TEMP%\stminstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\stminstaller.exe" 
echo Done! 
del "%TEMP%\stminstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
