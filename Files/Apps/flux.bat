@echo off
call logo.bat
echo.
echo f.lux Installer
echo ================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irm https://schooicodes.github.io/file_hosting/flux.ps1 | iex"
if %ERRORLEVEL% EQU 0 echo Success!
if NOT %ERRORLEVEL% EQU 0 echo Error: %ERRORLEVEL%
pause >nul
exit
