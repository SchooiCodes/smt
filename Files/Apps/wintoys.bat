@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
title Wintoys Installer
cd /d %~dp0
if exist logo.bat call logo.bat & echo.
echo Checking for winget...
winget --version >nul 2>&1
if NOT %errorlevel% equ 0 echo Installing winget... & start wg.bat
echo Installing Wintoys...
winget install WinToys
pause >nul
exit