@echo off
title Screenshot Tool
setlocal enabledelayedexpansion

:menu
cls
if exist logo.bat call logo.bat & echo.
echo Screenshot Tool
echo ===============
echo 1. Capture Screenshot
echo 2. Exit
set /p choice="Choose an option: "

if "%choice%"=="1" goto capture
if "%choice%"=="2" exit
goto menu

:capture
set /p filepath="Enter the file path to save the screenshot (e.g., C:\screenshot.png): "
powershell -command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $bmp = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height); $graphics = [System.Drawing.Graphics]::FromImage($bmp); $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size); $bmp.Save('%filepath%'); $bmp.Dispose(); $graphics.Dispose();"
echo Screenshot saved to %filepath%
pause
goto menu
