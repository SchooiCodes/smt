@echo off
if exist logo.bat call logo.bat & echo.
echo f.lux Installer
echo ================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://schooicodes.github.io/file_hosting/flux.ps1 | iex"
if %ERRORLEVEL% EQU 0 echo Success!
if NOT %ERRORLEVEL% EQU 0 echo Error: %ERRORLEVEL%
timeout /t 5 /NOBREAK >nul
exit
