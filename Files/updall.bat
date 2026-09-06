@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
title Update Every App ^| SMT
if exist logo.bat call logo.bat & echo.
echo Update Every App
echo ================
echo Checking for winget..
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 (
	echo Winget not found! Installing now.. 
	start /min /wait wg.bat
	if NOT EXIST ..\RefreshEnv.cmd (
		powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/chocolatey/choco/raw/refs/heads/master/src/chocolatey.resources/redirects/RefreshEnv.cmd -OutFile ..\RefreshEnv.cmd" & call ..\RefreshEnv
	) else (
		call ..\RefreshEnv
	)
)
winget update --all
echo Done.
pause
exit