@echo off
color 0f
cd /d "%~dp0"

:main
cls
call logo.bat
echo.
echo Schooi's School Utilities (nice)
echo ================================
echo 1. Game websites
echo 2. Pranks
echo 3. Info stealer (COMING SOON)
echo.
set /p choice=%username%@smt:~$ 
if "%choice%"=="1" goto web
if "%choice%"=="2" goto pranks
if "%choice%"=="3" goto IS
goto main

:web
cls
call logo.bat
echo.
echo Game Websites
echo =================
echo B. Go back
echo 1. Friv
echo 2. New Tyrone's Unblocked Games
echo 3. Tyrone's Unblocked Games
echo.
set /p site=%username%@smt:~$ 
if /i "%site%"=="b" goto main
if /i "%site%"=="1" start https://friv.com/
if /i "%site%"=="2" start https://sites.google.com/site/tyronesgamesez/ 
if /i "%site%"=="3" start https://tyronesgames.com/
goto web

:pranks
cls
call logo.bat
echo.
echo Pranks
echo ==========
echo B. Back
echo 1. HackerTyper
echo 2. GeekTyper
echo 3. GeekPrank
echo 4. Broken Screen ^& More Prank
echo.
set /p prank=%username%@smt:~$ 
if /i "%prank%"=="b" goto main
if /i "%prank%"=="1" start https://hackertyper.net/
if /i "%prank%"=="2" start https://geektyper.com
if /i "%prank%"=="3" start https://geekprank.com/
if /i "%prank%"=="4" start https://www.whitescreen.online/#:~:text=Play-,Prank%%20screens,-White%%20Noise
goto pranks
