@echo off
title 7zip Installer
goto elevate

:start
cd /d %~dp0
call logo.bat
echo.
echo 7zip Installer
echo ===============
echo Installing 7zip...
powershell -Command "$PSVersionTable.PSVersion.Major" > version.txt
set /p ps_version=<version.txt
del version.txt
if %ps_version% GEQ 3 (
    powershell -Command "irm https://raw.githubusercontent.com/SchooiCodes/file_hosting/main/7z.ps1 | iex"
) else (
    powershell -Command "$wc = New-Object System.Net.WebClient; $script = $wc.DownloadString('https://raw.githubusercontent.com/SchooiCodes/file_hosting/main/7z.ps1'); Invoke-Expression $script"
)
if %ERRORLEVEL% EQU 0 (
    echo Success!
) else (
    echo Error: %ERRORLEVEL%
)
pause >nul
exit

:elevate
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs"
    exit
)
goto start
