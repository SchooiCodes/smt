@echo off

:start
cls
call logo.bat
title NS Lookupper
echo.
echo NS Lookupper
echo =============
echo Please enter a sitename:
set /p nsl=^> 
nslookup %nsl%
echo.
pause
goto start
