@echo off
cd %~dp0
title MegaTemp [Rust] (Mega Mass Account Manager) ^| SMT
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s Visuals config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring..
goto main

:main
cls
if exist logo.bat call logo.bat & echo.
echo %BRIGHT_RED%Mega%RESET%Temp [Rust] (Mega Mass Account Manager)
echo ==========================================
if NOT EXIST MegaTemp_Rust.exe echo %BRIGHT_YELLOW%Downloading..%RESET% & powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/SchooiCodes/MegaTemp_Rust/releases/latest/download/megatemp-windows-x86_64.exe -OutFile MegaTemp_Rust.exe" & MegaTemp_Rust & exit
if EXIST MegaTemp_Rust.exe echo %BRIGHT_RED%Mega%RESET%Temp%BRIGHT_GREEN2% already downloaded%RESET%, running.. & MegaTemp_Rust.exe & exit