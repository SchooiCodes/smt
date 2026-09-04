@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Proton VPN Installer 
echo Proton VPN Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Proton.ProtonVPN 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://vpn.protondownload.com/download/ProtonVPN_v5.1.7_x64.exe"' -OutFile '%TEMP%\pvpninstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\pvpninstaller.exe" 
echo Done! 
del "%TEMP%\pvpninstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
