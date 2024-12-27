@echo off
if exist logo.bat call logo.bat & echo.
title IP Stealer
md IPs
cd IPs
echo IP STEALER
echo ========
echo Stealing IP..
ipconfig >> IP_Info_of_%username%.txt
if "%ERRORLEVEL%" == "0" echo SUCCESS ^| Successfully copied IP info and saved to "%~dp0IP_Info_of_%username%.txt".
if "%ERRORLEVEL%" == "1" echo ERROR ^| Couldn't copy IP info and save it to "%~dp0IP_Info_of_%username%.txt".
pause >nul
exit