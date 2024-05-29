@echo off
cd %~dp0
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
title Geek Uninstaller Installation
call logo.bat
echo.
echo Installing..
choco /? 1>nul
if NOT %ERRORLEVEL% EQU 0 goto :choco
goto geek

:geek
echo Downloading geek uninstaller..
choco install geekuninstaller -y
echo Moving geek uninstaller to Schooi's Multitool's folder..
xcopy /y C:\ProgramData\chocolatey\lib\geekuninstaller\tools\geek.exe %~dp0
echo Starting..
geek.exe
timeout /t 10 >nul
exit

:choco
echo Installing Chocolatey...
powershell Set-ExecutionPolicy AllSigned
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
PowerShell -Command "Start-Process '%0'
exit /b 0
