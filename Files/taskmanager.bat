@echo off
title Schooi's CLI Task Manager

:start
cls
if exist logo.bat call logo.bat & echo.
echo ===========================
echo        Task Manager
echo ===========================
echo.
echo What would you like to do?
echo 1. List all running processes
echo 2. Kill a process
echo 3. Start a process
set /p choice=^> 
if %choice%==1 goto tasklist
if %choice%==2 goto taskkill
if %choice%==3 goto taskstart
goto start

:tasklist
cls
if exist logo.bat call logo.bat & echo.
echo ===========================
echo       Process Lister
echo ===========================
echo.
echo Running Processes:
tasklist
pause >nul
goto start

:taskkill
cls
if exist logo.bat call logo.bat & echo.
echo ===========================
echo       Process Killer
echo ===========================
echo.
echo Please enter the name of the process you would like to kill
set /p kill=^> 
taskkill /f /im %kill% || taskkill /f /t /PID
pause >nul
goto start

:taskstart
cls
if exist logo.bat call logo.bat & echo.
echo ===========================
echo       Process Starter
echo ===========================
echo.
echo Enter the name of the executable or script to start (e.g., chrome.exe, notepad.exe, customScript.bat)
echo.
echo 1. Go Back
echo.
set /p taskChoice=Enter task or type '1' to go back: 
if "%taskChoice%"=="1" goto start
start "" "%taskChoice%"
if errorlevel 1 echo Failed to start "%taskChoice%". Please check the name and try again.
pause >nul
goto start