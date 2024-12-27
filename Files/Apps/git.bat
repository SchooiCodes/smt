@echo off
title git Installer
cd /d "%~dp0"
if exist logo.bat call logo.bat & echo.
echo Installing Git...
echo =====================
echo.
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
powershell Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.1/Git-2.41.0-64-bit.exe -OutFile $env:USERPROFILE\Downloads\Git-2.41.0-64-bit.exe
powershell Start-Process -FilePath "$env:USERPROFILE\Downloads\Git-2.41.0-64-bit.exe" -ArgumentList "/SILENT" -NoNewWindow -Wait
if %ERRORLEVEL%=="0" echo Success!
timeout /t 5 >nul
exit
