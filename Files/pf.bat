@echo off
pause
title Schooi's Multitool
fltmc >nul 2>&1 || (
    echo( && echo   [33m# Administrator privileges are required. && echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
call logo.bat
echo %cd%
echo.
echo This doesn't work well on USBs!
echo Would you like to add Schooi's Multitool to Program Files? (Y/N)
set /p pf=^> 
if "%pf%"=="N" exit
set scriptpath=%~dp0
cd %scriptpath%
cd ..
echo Current Directory: %cd%
xcopy /y SchooiMultitool.bat "C:\Program Files\Schooi's Multitool\"
cd %old_dir%
md "C:\Program Files\Schooi's Multitool\Files"
xcopy /y "Files" "C:\Program Files\Schooi's Multitool\Files\" /s
pause >nul
exit