@echo off
cd /d "%~dp0"
title UPPPE v1.1
if exist logo.bat call logo.bat & echo.
echo Welcome. Applying it now..
for /f "tokens=4 delims= " %%a in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61') do powercfg -setactive %%a
if "%ERRORLEVEL%"=="0" echo Success!
pause
exit