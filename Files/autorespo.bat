@echo off
cd %~dp0
title Restore Point Creator

:: Ensure the script is running with administrative privileges
fltmc >nul 2>&1 || (
	echo This script is not elevated!
	echo Requesting Admin permissions..
    PowerShell -Command "Start-Process PowerShell -ArgumentList 'Start-Process -Verb RunAs \"%~f0\"' -NoNewWindow " 2>nul || (
        >nul pause && exit /b 1
    )
    exit
)


:: Call logo.bat, ensure the path is correct
if exist "%~dp0logo.bat" (
    call "%~dp0logo.bat"
) else (
    echo logo.bat not found in %~dp0
    pause
    exit 1
)

echo.
echo Creating restore point...

:: Download and execute the PowerShell script
powershell -Command "iwr -useb https://schooicodes.github.io/file_hosting/autorespo.ps1 | iex"

:: Uncomment these lines if you want to use wmic for restore point creation
::wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Automatic Restore Point (Schooi's Multitool)", 100, 7
::if %errorlevel% EQU 0 (
::    echo Success!
::    pause
::    exit
::) else (
::    echo Error! Errorlevel: %errorlevel%
::)

pause