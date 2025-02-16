@echo off

:start
title Powershell 7 Installer
cd /d "%~dp0"
if exist logo.bat call logo.bat & echo.
echo Powershell 7 (pwsh) Installer
echo ================================
echo Checking for winget...
winget.exe -v 2>nul
if NOT %ERRORLEVEL% EQU 0 goto winget
echo Installing Powershell...
winget.exe install --id Microsoft.PowerShell
echo Installation complete. Please restart your computer to complete the setup.
timeout /t 5 /NOBREAK >nul
exit


:winget
@echo off
:: Install .NET Framework 4.6.2
echo Downloading .NET Framework 4.6.2 installer...
bitsadmin /transfer netframework https://download.visualstudio.microsoft.com/download/pr/10461429/AC101D64-D9E4-4894-85D2-79ED020E6B7C/NDP462-KB3151800-x86-x64-AllOS-ENU.exe %temp%\NDP462-KB3151800-x86-x64-AllOS-ENU.exe
echo Installing .NET Framework 4.6.2...
start /wait %temp%\NDP462-KB3151800-x86-x64-AllOS-ENU.exe /quiet /norestart

:: Install Windows Management Framework 5.1
echo Downloading Windows Management Framework 5.1 installer...
bitsadmin /transfer wmf51 https://download.microsoft.com/download/1/C/C/1CC238B2-91F2-40EF-AB03-A0D973326712/Win7AndW2K8R2-KB3191566-x64.msu %temp%\Win7AndW2K8R2-KB3191566-x64.msu
echo Installing Windows Management Framework 5.1...
start /wait wusa %temp%\Win7AndW2K8R2-KB3191566-x64.msu /quiet /norestart

:: Install Chocolatey
echo Installing Chocolatey...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

echo Installing Winget...
choco install winget -y
timeout /t 3 >NUL
PowerShell -Command "Start-Process '%~dpnx0'
exit /b 0
goto start