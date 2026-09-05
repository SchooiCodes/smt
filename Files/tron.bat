@echo off
cd /d "%~dp0"
title Tron - SMT
if exist logo.bat call logo.bat & echo.
echo THIS SCRIPT WILL AUTOMATICALLY RUN TRON.
echo YOUR COMPUTER WILL AUTOMATICALLY RESTART.
echo PLEASE CLOSE ALL APPS BEFORE PROCEEDING.
echo RUNNING TRON CAN TAKE FROM 3 TO 10 HOURS.
echo.
echo Press any key to proceed..
pause >nul
echo Downloading Tron via torrent..
if not exist "C:\Program Files\qbittorrent\qbittorrent.exe" echo An installation of qBittorrent was not found. Installing it now.. (this may take a long time)
if not exist "C:\Program Files\qbittorrent\qbittorrent.exe" powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/SchooiCodes/smt/raw/refs/heads/main/Files/Apps/qbt.bat -OutFile %TEMP%\qbt.bat" && start /MIN /WAIT "" "%TEMP%\qbt.bat" & del "%TEMP%\qbt.bat" & echo. 
echo Applying required settings..
taskkill /f /im qBittorrent.exe >nul 2>&1
if exist "%appdata%\qBittorrent_smt" rd /s /q "%appdata%\qBittorrent_smt"
md "%appdata%\qBittorrent_smt"
echo [AutoRun]>"%appdata%\qBittorrent_smt\qBittorrent.ini"
echo enabled=true>>"%appdata%\qBittorrent_smt\qBittorrent.ini"
echo program=cmd /c \"taskkill /f /im qbittorrent.exe\">>"%appdata%\qBittorrent_smt\qBittorrent.ini"
echo.
echo Legal Notice
echo qBittorrent is a file sharing program. When you run a torrent, its data will be made available to others by means of upload. Any content you share is your sole responsibility.
echo.
start /MIN /WAIT "" "C:\Program Files\qbittorrent\qbittorrent.exe" "magnet:?xt=urn:btih:1b4d2f1ca6893625f1d655b127762210c8be7203&dn=Tron%%20v12.0.8%%20%%282025-01-09%%29&tr=udp%%3A%%2F%%2Ftracker.publicbt.com%%3A80&tr=http%%3A%%2F%%2Ftracker.openbittorrent.com%%3A80%%2Fannounce&tr=udp%%3A%%2F%%2Ftracker.ccc.de%%3A80%%2Fannounce&tr=udp%%3A%%2F%%2Ftracker.istole.it%%3A80&tr=http%%3A%%2F%%2F9.rarbg.com%%3A2710%%2Fannounce&tr=http%%3A%%2F%%2Ftracker.ipv6tracker.org%%3A80%%2Fannounce&tr=udp%%3A%%2F%%2Ftracker.coppersurfer.tk%%3A6969%%2Fannounce" --save-path="." --skip-dialog --configuration=smt --confirm-legal-notice
rd /s /q "%localappdata%\qBittorrent_smt\BT_backup"
echo Setting up Tron..
cd "Tron v12.0.8 (2025-01-09)"
copy tron.bat "%USERPROFILE%\Desktop\" >nul
if exist "%USERPROFILE%\Desktop\resources" echo "%USERPROFILE%\Desktop\resources" already exists. Renaming to resources_old.. & ren "%USERPROFILE%\Desktop\resources" resources_old >nul
copy resources "%USERPROFILE%\Desktop\" >nul
copy /y runtron.bat "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" >nul
echo Restarting..
shutdown -r -t 0
pause
exit