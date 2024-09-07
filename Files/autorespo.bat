@echo off
cd /d "%~dp0"
title Restore Point Creator
fltmc >nul 2>&1 || (
	echo This script is not elevated!
	echo Requesting Admin permissions..
    PowerShell -Command "Start-Process PowerShell -ArgumentList 'Start-Process -Verb RunAs "%0"' -NoNewWindow " 2>nul || (
        >nul pause && exit /b 1
    )
    exit
)
call logo.bat
echo.
echo Creating restore point...
REM Uncomment these lines if you want to use script downloading for restore point creation
REM powershell -Command "iwr -useb https://schooicodes.github.io/file_hosting/autorespo.ps1 | iex"
if not exist autorespo.ps1 type ar.txt>>autorespo.ps1
powershell -Command "iex .\autorespo.ps1"
:: Uncomment these lines if you want to use wmic for restore point creation
::wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Automatic Restore Point (Schooi's Multitool)", 100, 7
::if %errorlevel% EQU 0 (
::    echo Success!
::    pause
::    exit
::) else (
::    echo Error! Errorlevel: %errorlevel%
::)
echo Press any key to exit.
pause >nul
exit
