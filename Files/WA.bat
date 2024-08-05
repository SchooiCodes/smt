@echo off
title Windows Activator - Made by MassGrave
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
call logo.bat
echo.
echo Windows Activator - Script made by MassGrave
echo https://massgrave.dev/
powershell -Command "iwr -useb https://massgrave.dev/get | iex"