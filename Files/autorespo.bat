@echo off
title Restore Point Creator
call logo.bat
echo.
echo Creating restore point...
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Automatic Restore Point (Schooi's Multitool)", 100, 7
if %errorlevel% EQU 0 echo Success! & pause & exit
echo Error! Errorlevel: %errorlevel%
pause
