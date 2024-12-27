@echo off
color 0f
title Elevation Required
echo.
echo Elevation Required
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d "%~dp0"
title User Manager

:main
cls
if exist logo.bat call logo.bat & echo.
echo Welcome to the user manager!
echo -------------------------------------------
echo What would you like to do?
echo 1. View all users
echo 2. View a user's info
echo 3. Reset a user's password (DOESN'T REQUIRE EXISTING PASSWORD)
echo 4. Rename a user
set /p choice=^> 


if "%choice%"=="1" (
    net user
	pause >nul
	goto main
)
if "%choice%"=="2" goto userinfo
if "%choice%"=="3" goto reset
if "%choice%"=="4" goto rename
goto main

:userinfo
echo.
set /p iuser=Please enter the name of the user whose info you would like to see: 
echo.
echo =========================================
echo.
net user %iuser% 
pause >nul
goto main

:reset
echo.
set /p ruser=Please enter the name of the user whose password you would like to reset: 
net user %ruser% *
pause >nul
goto main

:rename
echo.
set /p renuser=Please enter the name of the user who you want to rename: 
set /p renusernew=Please enter the new name of the user who you want to rename: 
wmic useraccount where name='%renuser%' rename '%renusernew%' >nul
cd C:\Users\
ren "%renuser%" "%renusernew%" >nul 2>&1
echo Done.
pause >nul
cd /d "%~dp0"
goto main