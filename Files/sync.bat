@echo off
echo %~dp0 | findstr "C:\Program" >nul
if %ERRORLEVEL% EQU 0 set found=true
echo %~dp0 | findstr "System32" >nul
if %ERRORLEVEL% EQU 0 set found=true
if "%found%"=="true" (
	fltmc >nul 2>&1 || (
		echo This script is not elevated!
		echo Requesting Admin permissions..
		PowerShell -Command "Start-Process PowerShell -ArgumentList 'Start-Process -Verb RunAs \"%~f0\"' -NoNewWindow " 2>nul || (
			>nul pause && exit /b 1
		)
		exit
	)
)
cd /d "%~dp0"
if exist logo.bat call logo.bat & echo.
echo Running sync..
cd ..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/SchooiCodes/file_hosting/refs/heads/main/sync.ps1 -OutFile sync.ps1"
powershell ./sync.ps1 
del sync.ps1
exit