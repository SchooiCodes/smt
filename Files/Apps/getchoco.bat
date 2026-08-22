@echo off
fltmc >nul 2>&1 || (
	PowerShell Start -Verb RunAs '%0' 2> nul || (
		>nul pause && exit 1
	)
	exit 0
)
cd /d "%~dp0"
title Chocolatey Installer
if exist logo.bat call logo.bat & echo.
echo Chocolatey (choco) Installer
echo ============================
echo Installing choco..
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
echo Script finished.
timeout /t 5 >nul
exit