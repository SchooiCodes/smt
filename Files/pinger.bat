@echo off & cls
title IP Pinger
echo IP Pinger
set /p x=CONSOLE ^| Enter IP Here: 
echo.
echo ========================================================
call :ColorText 0a PING -n 1 %x% | FIND "TTL="
IF ERRORLEVEL 1 (call :ColorText c CONSOLE ^| IP Is Now OFFLINE, or you just got RATELIMITED!)               
REM set /a ZULA=(%Random%%%9)+1
REM color %ZULA%
ping -t 1 0 10 127.0.0.1 >nul
goto top+-
:choice
set /p c=CONSOLE ^| Do you want to exit {Y/N}? 
if /I "%c%" EQU "y" goto :q
if /I "%c%" EQU "n" goto main
goto :choice

:q
echo goodbye :)
timeout /t 2 >nul
goto main

:top
PING -n 1 %x% | FIND "TTL="
IF ERRORLEVEL 1 (call :ColorText c CONSOLE ^| IP Is Now OFFLINE, or you just got RATELIMITED!)                     
REM set /a ZULA=(%Random%%%9)+1
REM color %ZULA%
ping -t 1 0 10 127.0.0.1 >nul
GoTo top+-

:ColorText
<nul set /p "=^[[%1m%~2^[[0m"
exit /b
