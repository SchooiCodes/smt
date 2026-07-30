@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Rainmeter Installer 
echo Rainmeter Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Rainmeter.Rainmeter 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/rainmeter/rainmeter/releases/download/v4.5.26.3894/Rainmeter-4.5.26.exe"' -OutFile '%TEMP%\rmtinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\rmtinstaller.exe" 
echo Done! 
del "%TEMP%\rmtinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
