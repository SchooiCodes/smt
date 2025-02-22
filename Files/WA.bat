@echo off
title Windows Activator - Made by MassGrave
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
if exist logo.bat call logo.bat & echo.
echo Windows Activator - Script made by MassGrave
echo https://massgrave.dev/
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://get.activated.win | iex"
timeout /t 5 /NOBREAK >nul
exit