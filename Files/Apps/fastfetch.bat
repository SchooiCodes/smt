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
where scoop >nul 2>nul
if NOT %ERRORLEVEL% EQU 0 call :scoop
echo Installing Fastfetch...
cmd /c "%USERPROFILE%\scoop\shims\scoop.cmd" install fastfetch
if %ERRORLEVEL% EQU 0 (echo Operation succeeded.) else (echo Operation failed.)
pause
exit

:scoop
echo Installing Scoop...
cmd /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
cmd /c powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm get.scoop.sh | iex"
goto :EOF
