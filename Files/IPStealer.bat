@echo off
title IP Stealer
md IPs
cd IPs
echo IP STEALER
echo ========
echo Stealing IP..
ipconfig >> IP_Info_of_%username%.txt
if "%ERRORLEVEL%" == "0" echo SUCCESS ^| Successfully copied IP info and saved to "IP_Info_of_%username%.txt" in "IPs" in the "Schooi's Multitool" folder.
if "%ERRORLEVEL%" == "1" echo ERROR ^| Couldn't copy IP info and save it to "IP_Info_of_%username%.txt" in "IPs" in the "Schooi's Multitool" folder.
pause >nul
exit