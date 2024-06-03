@echo off

:start
cls
call logo.bat
echo.
title Internet Route Tracer
echo Internet Route Tracer
echo ======================
echo Please enter an IP address or a sitename:
set /p trt=^> 
tracert %trt%
echo.
pause
goto start