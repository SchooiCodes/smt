@echo off
title UPPPE v1.1
echo Welcome. Applying it now..
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
if "%ERRORLEVEL%"="0" echo Success!
pause
exit