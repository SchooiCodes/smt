@echo off
net session >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo Restarting as non-admin...
    runas /trustlevel:0x20000 "%~f0"
	exit
)
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title uv Installer 
echo uv Installer 
echo ==================
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
echo Done.
pause
exit