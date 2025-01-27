@echo off
title qBittorrent Installer
if exist logo.bat call logo.bat & echo. 
echo qBittorrent Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://unlimited.dl.sourceforge.net/project/qbittorrent/qbittorrent-win32/qbittorrent-5.0.3/qbittorrent_5.0.3_x64_setup.exe?viasf=1 -OutFile '%TEMP%\qbtinstaller.exe'"
echo Installing..
start /WAIT "" "%TEMP%\qbtinstaller.exe"
echo Done!
del "%TEMP%\qbtinstaller.exe" >nul
pause >nul
exit