@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Python Install Manager Installer 
echo Python Install Manager Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Python.PythonInstallManager 
if %ERRORLEVEL% NEQ 0 goto irm 
timeout /t 5 /NOBREAK >nul 
exit 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://www.python.org/ftp/python/pymanager/python-manager-26.3.msix"' -OutFile '%TEMP%\piminstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\piminstaller.exe" 
echo Done! 
del "%TEMP%\piminstaller.exe" >nul 
timeout /t 5 /NOBREAK >nul 
exit 
