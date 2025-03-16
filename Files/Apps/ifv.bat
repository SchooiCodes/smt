@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title IrfanView Installer 
echo IrfanView Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id IrfanSkiljan.IrfanView 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://altushost-swe.dl.sourceforge.net/project/irfanview/iview462_setup.exe?viasf=1"' -OutFile '%TEMP%\ifvinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\ifvinstaller.exe" 
echo Done! 
del "%TEMP%\ifvinstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
