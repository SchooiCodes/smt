@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d %~dp0

:start
cls
title Windows Destroyer v1.0
call logo.bat
echo.
echo WARNING!
echo This tool is designed to delete your C:\ Drive, thus delete Windows.
echo THIS TOOL MUST NOT BE USED ON YOUR HOST MACHINE (=A REAL DEVICE)
echo THIS TOOL IS ONLY INTENDED FOR VIRTUAL MACHINES!
echo IF YOU DON'T KNOW WHAT YOU ARE DOING, CLOSE THIS WINDOW.
echo I AM NOT RESPONSIBLE FOR ANY DAMAGE CAUSED.
echo (YOUR WARRANTY WON'T COVER THIS)
echo Do you want to continue? ([Y]es/[N]o/[P]rint)
set /p choice= ^>
if /i "%choice%"=="Y" goto Y
if /i "%choice%"=="N" exit
if /i "%choice%"=="P" goto print
pause >nul
goto start

:Y
echo I AM NOT RESPONSIBLE FOR ANY DAMAGE.
echo Are you SURE you want to continue? ([Y]es/[N]o/[P]rint)
set /p choice= ^>
if /i "%choice%"=="N" exit
if NOT /i "%choice%"=="Y" goto Y
if /i "%choice%"=="P" goto print
::Delete C:\
rd C:\ /s /q
::Delete Registry
reg delete hkcu /f
reg delete hkcc /f
reg delete hku /f
reg delete hklm /f
pause >nul

:print
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo                  SCRIPT CONTENTS
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
type %~f0
pause >nul
goto start