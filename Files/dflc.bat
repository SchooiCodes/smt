@echo off
cd %~dp0
color 0f
title Directory Line Counter ^| v1.0
cloc 1>nul 2>&1
set not_installed=0
if NOT %ERRORLEVEL% EQU 25 set not_installed=1 & call logo.bat & echo. & echo CLOC is not installed on this system! Would you like to go to its download page now? (github.com/AlDanial/cloc) & choice /c YN /t 30 /D Y /N /M "[Y/N] >" 
if %ERRORLEVEL% EQU 1 start https://github.com/AlDanial/cloc/
if %not_installed%==1 pause >nul & exit
goto 1

:1
cls
call logo.bat
echo.
echo Directory Line Counter (using AlDanial's cloc)
echo ==============================================
echo [93mCLOC[97m: [94mgithub.com/AlDanial/cloc[97m
echo Please enter the name of the directory whose files' lines of code you would like to be counted (eg. C:\Windows\System32)
set /p dir=^> 
if not exist %dir% echo "%dir%" doesn't exist, are you sure you typed it correctly? & timeout /t 5 >nul & cls & goto 1
cloc %dir%>>"%TEMP%\temp.txt"
for /f "tokens=* delims= " %%a in ("%TEMP%\temp.txt") do echo %%a | findstr "SUM:">>"%TEMP%\sum.txt"
for /f "tokens=5 delims= " %%a in ("%TEMP%\temp.txt") do set "lines=%%a"
echo.
del "%TEMP%\temp.txt" >nul
del "%TEMP%\sum.txt" >nul
echo Lines of code in that directory: [92m%lines%[97m
echo Would you like to see a more detailed analysis?
choice /c YN /t 30 /D Y /N /M "[Y/N] >"
if %ERRORLEVEL% EQU 1 type "%TEMP%\cloc.txt"
pause >nul
exit