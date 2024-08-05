@echo off
title Fastfetch Installer

call logo.bat
echo.
echo Fastfetch Installer
echo ====================
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

powershell -Command "iwr -useb get.scoop.sh | iex"
timeout /t 5 >nul
scoop install fastfetch

if ERRORLEVEL 0 echo Operation succeeded.
pause >nul
exit
