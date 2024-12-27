@echo off
cd /d "%~dp0"
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
title Computer Error Scanner
if exist logo.bat call logo.bat & echo.
echo Checking your computer for errors
echo -----------------------------------------
echo Checking Windows System File Integrity...
sfc /scannow
echo Checking DISM..
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
echo Checking Disk...
chkdsk /f
chkdsk /r
echo Check officially over.
pause
exit