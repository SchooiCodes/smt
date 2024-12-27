@echo off
title System Info
if exist logo.bat call logo.bat & echo.
echo System Info:
systeminfo
pause >nul
exit