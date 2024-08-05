@echo off
title Elevation Required
echo.
echo Elevation Required
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d %~dp0
title User Manager

:main
cls
call logo.bat
echo.
echo Welcome to the user password resetter!
echo -------------------------------------------
echo What would you like to do?
echo 1. View all users
echo 2. View a user's info
echo 3. Reset a user's password (DOESN'T REQUIRE EXISTING PASSWORD)
set /p choice=^> 


if "%choice%"=="1" (
    net user
	pause >nul
	goto main
)
if "%choice%"=="2" goto userinfo
if "%choice%"=="3" goto reset

:userinfo
set /p iuser=Please enter the name of the user whose info you would like to see: 
echo.
echo =========================================
echo.
net user %iuser% 
pause >nul
goto main

:reset
set /p ruser=Please enter the name of the user whose password you would like to reset: 
net user %ruser% *
pause >nul
goto main