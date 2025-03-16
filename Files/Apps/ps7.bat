@echo off
title Powershell 7 Installer
cd /d "%~dp0"
if exist logo.bat call logo.bat & echo.
echo Powershell 7 (pwsh) Installer
echo ================================
echo Checking for winget...
winget.exe -v 2>&1 >nul
if NOT %ERRORLEVEL% EQU 0 call wg.bat
echo Installing Powershell 7...
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Microsoft.PowerShell
echo Installation complete. Please restart your computer to complete the setup.
timeout /t 5 /NOBREAK >nul
exit