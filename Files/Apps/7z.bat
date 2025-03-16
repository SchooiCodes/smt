@echo off
title 7-Zip Installer
if exist logo.bat call logo.bat & echo. 
echo 7-Zip Installer
echo ==================
winget --version 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 goto irm
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id 7zip.7zip
if %ERRORLEVEL% NEQ 0 goto irm
timeout /t 5 /NOBREAK >nul
exit

:irm
echo Winget not found! Falling back to irm..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/SchooiCodes/file_hosting/main/7z.ps1 | iex"
echo Installing..
start /WAIT "" "%TEMP%\7zinstaller.exe"
echo Done!
del "%TEMP%\7zinstaller.exe" >nul
timeout /t 5 /NOBREAK >nul
exit