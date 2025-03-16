:: Script by @curlyhair. on discord
:: Thanks for helping (and watching me yap)

@echo off
title Any App Installer (based on winget)

:appinstaller
if exist logo.bat call logo.bat & echo.
echo Any App Installer (based on winget)
echo ====================================
::smt stuff, don't remove
::TASK:
::ask user for the ID of the app
::use winget install -e --id to install the app
::tip: variables are stored in %var%

:: task here
set /p id=Please type the winget ID of the app you want to install: 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id %id%
:: end of task

echo Done.
if ERRORLEVEL NEQ 0 echo Something went wrong! Errorlevel: %ERRORLEVEL%
timeout /t 5 /NOBREAK >nul
cls
goto appinstaller

