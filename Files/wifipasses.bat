@echo off
title Schooi's Wi-Fi Password Viewer

:start
call :greet
echo Would you like to see a list of all Wi-Fis? ([Y]es/[N]o)
set /p list=^> 
if /i %list%=="Y" (
	@echo on
	netsh wlan show profile
	@echo off
	)
pause >nul
cls
call :greet
echo Please enter the name of the Wi-Fi whose password you would like to see:
set /p wifi=^> 
netsh wlan show profile name="%wifi%" key=clear
pause
goto start

:greet
cls
cd %~dp0
call logo.bat
echo.
echo Wi-Fi Password Viewer
echo ======================
