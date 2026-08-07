@echo off
cd %~dp0
title MegaTemp (Mega Mass Account Manager) ^| SMT
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring..
goto main

:main
cls
if exist logo.bat call logo.bat & echo.
echo %BRIGHT_RED%Mega%RESET%Temp (Mega Mass Account Manager)
echo ====================================
if NOT EXIST MegaTemp.exe echo %BRIGHT_YELLOW%Downloading..%RESET% & powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/SchooiCodes/MegaTemp/releases/download/latest/MegaTemp-windows.exe -OutFile MegaTemp.exe" & MegaTemp & exit
if EXIST MegaTemp.exe echo %BRIGHT_RED%Mega%RESET%Temp%BRIGHT_GREEN2% already downloaded%RESET%, running.. & MegaTemp.exe & exit