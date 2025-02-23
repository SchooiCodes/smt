@echo off
cd /d "%~dp0"
title Never Gonna Give You Up Music
setlocal enabledelayedexpansion
set "filePath=C:\path\to\your\file.txt"
for %%F in ("%filePath%") do set "folderPath=%%~dpF"
endlocal
set "tempFile=%folderPath%test_admin_perms.tmp"
echo Testing > "%tempFile%" 2>nul

:loop
net session >nul 2>&1
if %errorLevel% == 2 (
	tasklist /FI "WindowTitle eq Get rickrolled!" > "%TEMP%\running.txt"
) else (
	tasklist /FI "WindowTitle eq Administrator:  Get rickrolled!" > "%TEMP%\running.txt"
)
for /f "tokens=* delims=" %%a in (%TEMP%\running.txt) do (
	set line=%%a
	if "%line%"=="INFO: No tasks are running which match the specified criteria." taskkill /f /im cscript.exe & del music.mp3 & del sound.vbs & del start.vbs & del /f /q "%tempFile%" 2>nul & exit
)
goto loop