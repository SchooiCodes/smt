@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
title Driver Backupper ^| v1.0
cd /d %~dp0
call logo.bat
echo.
echo Driver Backupper
echo =============
echo Please enter the export location (the place where the backups will be stored. I recommend you give this script an empty folder)
echo It has to be a full path, eg. C:\Windows\system32 or D:\Drivers Backup
set /p loc=^>
dism /online /export-driver /destination:"%loc%"
if %ERRORLEVEL% EQU 0 echo Success!
if NOT %ERRORLEVEL% EQU 0 echo Error: %ERRORLEVEL%
pause >nul
exit
