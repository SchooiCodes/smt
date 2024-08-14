@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d "%~dp0"
title SSAMBYO Fixer*
call logo.bat
echo.
echo "Some Settings Are Managed By Your Organization" Fixer
echo =======================================================
echo Starting..
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies" /f
reg delete "HKLM\Software\Microsoft\WindowsSelfHost" /f
reg delete "HKLM\Software\Policies" /f
reg delete "HKLM\Software\WOW6432Node\Microsoft\Policies" /f
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Policies" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies" /f
reg delete "HKCU\Software\Microsoft\WindowsSelfHost" /f
reg delete "HKCU\Software\Policies" /f
reg delete "HKLM\Software\Microsoft\Policies" /f
echo Finished.
echo =======================================================
echo If you saw any errors, don't worry, you're supposed to see them!
echo Would you like to restart your pc to apply these changes? ([Y]es)([N]o)
set /p choice=^> 
if /i %choice%=="Y" shutdown -r -t 0
if /i %choice%=="N" exit