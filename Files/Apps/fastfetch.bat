@echo off
cd /d "%~dp0"
title Fastfetch Installer
if exist logo.bat call logo.bat & echo.
echo Fastfetch Installer
echo ====================
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Restarting as non-admin...
    runas /trustlevel:0x20000 "%~f0"
	exit
)
where scoop.cmd >nul 2>&1
if NOT %ERRORLEVEL% EQU 0 echo Scoop not found. Running installer.. & start /WAIT "" getscoop.bat & if NOT EXIST ..\RefreshEnv.cmd powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/chocolatey/choco/raw/refs/heads/master/src/chocolatey.resources/redirects/RefreshEnv.cmd -OutFile ..\RefreshEnv.cmd" & ..\RefreshEnv
echo Installing Fastfetch...
scoop install fastfetch
if %ERRORLEVEL% EQU 0 (echo Operation succeeded.) else (echo Operation failed.)
pause
exit
