@echo off
title Schooi's Multitool

fltmc >nul 2>&1 || (
	echo This script is not elevated!
	echo Requesting Admin permissions..
    PowerShell -Command "Start-Process PowerShell -ArgumentList 'Start-Process -Verb RunAs \"%~f0\"' -NoNewWindow " 2>nul || (
        >nul pause && exit /b 1
    )
    exit
)
cd /d %~dp0
call logo.bat
echo.
echo Would you like to add Schooi's Multitool to Program Files? (Y/N)
set /p pf=^> 
if "%pf%"=="N" exit
cd /d ..
xcopy /y SchooiMultitool.bat "C:\Program Files\Schooi's Multitool\" >nul
xcopy /y "Files\" "C:\Program Files\Schooi's Multitool\Files\" /s /q >nul
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Schooi's Multitool.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Program Files\SchooiMultitool\SchooiMultitool.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
echo.
if ERRORLEVEL 0 echo Success!
if NOT ERRORLEVEL 0 echo An error has occurred!
pause >nul
exit