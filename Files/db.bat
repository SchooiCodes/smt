@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
title Drivers Backup ^| v1.0
echo Hello, and welcome to Drivers Backup, another tool created by - guess who - SCHOOI! Let's get started
echo Please enter the export location (the place where the backups will be stored. We recommend you give this script an empty folder)
echo It has to be a full path, eg. C:\Windows\system32 or D:\Drivers Backup
set /p loc=^>
dism /online /export-driver /destination:"%loc%"
pause >nul
exit