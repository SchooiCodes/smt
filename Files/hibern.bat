@echo off
title Hibernation [ON/OFF]
if exist logo.bat call logo.bat & echo.
echo Enable/Disable Hibernation
echo ============================
echo Would you like to enable or disable hibernation? ([E]nable/[D]isable)
set /p choice=^> 
if /i %choice%=="E" powercfg /hibernate on
if /i %choice%=="D" powercfg /hibernate off
echo.
echo Done.
pause >nul
exit