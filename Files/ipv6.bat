@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
title IPv6 Disabler ^| SMT
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring.. 
goto main

:main
cls
if exist logo.bat call logo.bat & echo.
echo IPv6 Disabler
echo ==============
echo This script %BRIGHT_RED%disables%RESET% IPv6 on all of the device's network adapters.
echo Press any key to run the operation now..
pause >nul
echo.
netsh interface ipv6 set global randomizeidentifiers=disabled | find "Ok." >nul
if NOT ERRORLEVEL 0 echo NETSH command %BRIGHT_RED%failed%RESET%! & set "failed=true"
if NOT "%failed%"=="true" echo NETSH command %BRIGHT_GREEN2%succeeded%RESET%!
powershell -Command "Get-NetAdapter | ForEach-Object { Disable-NetAdapterBinding -Name $_.Name -ComponentID ms_tcpip6 }"
if NOT ERRORLEVEL 0 echo Powershell Disable-NetAdapterBinding %BRIGHT_RED%failed%RESET%! & set "psfailed=true"
if NOT "%psfailed%"=="true" echo Powershell Disable-NetAdapterBinding %BRIGHT_GREEN2%succeeded%RESET%!
if NOT "%psfailed%"=="true" (if NOT "%failed%"=="true" (echo %BRIGHT_GREEN2%Success!%RESET%) else (echo %BRIGHT_RED%Something went wrong.%RESET%)) else (echo %BRIGHT_RED%Something went wrong.%RESET%)
echo.
echo Press any key to exit..
pause >nul
exit