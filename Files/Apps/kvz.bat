@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Keyviz Installer 
echo Keyviz Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id mulaRahul.Keyviz 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://github.com/mulaRahul/keyviz/releases/download/v2.1.1/keyviz_2.1.1_windows.msi"' -OutFile '%TEMP%\kvzinstaller.msi'" 
echo Installing.. 
start /WAIT "" "%TEMP%\kvzinstaller.msi" 
echo Done! 
del "%TEMP%\kvzinstaller.msi" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
