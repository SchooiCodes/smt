@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Spotify Installer 
echo Spotify Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Spotify.Spotify 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://download.scdn.co/SpotifyFullSetupX64.exe"' -OutFile '%TEMP%\sptinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\sptinstaller.exe" 
echo Done! 
del "%TEMP%\sptinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
