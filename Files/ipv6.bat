@echo off
set "MODE=disable"
if /I "%~1"=="--revert" set "MODE=revert"
if /I "%~1"=="/revert" set "MODE=revert"

fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs -FilePath '%0' -ArgumentList '%*' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
if "%MODE%"=="revert" (title IPv6 Re-enabler ^| SMT) else (title IPv6 Disabler ^| SMT)
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring.. 
goto main

:main
cls
if exist logo.bat call logo.bat & echo.
if "%MODE%"=="revert" (
    echo IPv6 Re-enabler
    echo ==============
    echo This script %BRIGHT_GREEN2%re-enables%RESET% IPv6 on all of the device's network adapters.
) else (
    echo IPv6 Disabler
    echo ==============
    echo This script %BRIGHT_RED%disables%RESET% IPv6 on all of the device's network adapters.
)
echo Press any key to run the operation now..
pause >nul
echo.

if "%MODE%"=="revert" (
    netsh interface ipv6 set global randomizeidentifiers=enabled | find "Ok." >nul
    if NOT ERRORLEVEL 0 echo NETSH command %BRIGHT_RED%failed%RESET%! & set "failed=true"
    if NOT "%failed%"=="true" echo NETSH command %BRIGHT_GREEN2%succeeded%RESET%!
    powershell -Command "Get-NetAdapter | ForEach-Object { Enable-NetAdapterBinding -Name $_.Name -ComponentID ms_tcpip6 }"
    if NOT ERRORLEVEL 0 echo Powershell Enable-NetAdapterBinding %BRIGHT_RED%failed%RESET%! & set "psfailed=true"
    if NOT "%psfailed%"=="true" echo Powershell Enable-NetAdapterBinding %BRIGHT_GREEN2%succeeded%RESET%!
) else (
    netsh interface ipv6 set global randomizeidentifiers=disabled | find "Ok." >nul
    if NOT ERRORLEVEL 0 echo NETSH command %BRIGHT_RED%failed%RESET%! & set "failed=true"
    if NOT "%failed%"=="true" echo NETSH command %BRIGHT_GREEN2%succeeded%RESET%!
    powershell -Command "Get-NetAdapter | ForEach-Object { Disable-NetAdapterBinding -Name $_.Name -ComponentID ms_tcpip6 }"
    if NOT ERRORLEVEL 0 echo Powershell Disable-NetAdapterBinding %BRIGHT_RED%failed%RESET%! & set "psfailed=true"
    if NOT "%psfailed%"=="true" echo Powershell Disable-NetAdapterBinding %BRIGHT_GREEN2%succeeded%RESET%!
)

if NOT "%psfailed%"=="true" (if NOT "%failed%"=="true" (echo %BRIGHT_GREEN2%Success!%RESET%) else (echo %BRIGHT_RED%Something went wrong.%RESET%)) else (echo %BRIGHT_RED%Something went wrong.%RESET%)
echo.
echo Press any key to exit..
pause >nul
exit