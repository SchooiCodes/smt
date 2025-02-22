@echo off
title qBittorrent Installer
if exist logo.bat call logo.bat & echo. 
echo qBittorrent Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install -e --accept-package-agreements --force --id qBittorrent.qBittorrent
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://altushost-swe.dl.sourceforge.net/project/qbittorrent/qbittorrent-win32/qbittorrent-5.0.3/qbittorrent_5.0.3_x64_setup.exe?viasf=1 -OutFile '%TEMP%\qbtinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\qbtinstaller.exe"
echo Done!
del "%TEMP%\qbtinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit