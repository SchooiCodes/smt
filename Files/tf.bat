@echo off
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d %~dp0
title Time Freeze
call logo.bat
echo.
echo Time Freeze
echo ============
echo Inspired by @endermanch
echo YOU WILL NEED TO SYNCHRONIZE THE TIME AGAIN AFTER THIS, KEEP THAT IN MIND.
echo Press any key to freeze time
pause >nul
echo Freezing Time..
for /F "tokens=2" %%i in ('date /t') do set date=%%i
set time=%time%
goto a

:a
date %date% >nul
time %time% >nul
ping 1.1.1.1 -n 1 -w 900 > nul
goto a