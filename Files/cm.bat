@echo off
title Clipboard Manager
setlocal enabledelayedexpansion

:menu
cls
if exist logo.bat call logo.bat & echo.
echo Clipboard Manager
echo =================
echo 1. Save Clipboard
echo 2. View Clipboard History
echo 3. Exit
set /p choice="Choose an option: "

if "%choice%"=="1" goto save
if "%choice%"=="2" goto view
if "%choice%"=="3" exit
goto menu

:save
for /f "tokens=*" %%a in ('powershell -Command "Get-Clipboard"') do set clipboard=%%a
set /a count+=1
echo !count!. !clipboard! >> clipboard_history.txt
echo Clipboard saved!
pause
goto menu

:view
cls
if exist clipboard_history.txt (
    type clipboard_history.txt
) else (
    echo No clipboard history found.
)
pause
goto menu
