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
goto disclaimer

:disclaimer
cd /d %~dp0
cls
call logo.bat
echo.
echo DISCLAIMER:
echo When you want to run SMT (the system32 version) you will need to know these things.
echo 1. When you run SMT from the Run dialog or CMD, you may need to run it as admin. (CTRL + SHIFT + ENTER for the Run dialog and you need to run cmd as admin for cmd)
echo 2. To run SMT you will type smt, not SchooiMultitool!
echo 3. I am not responsible for any damage! Make a restore point before using any tools! (Go to the tools, Create a System Restore Point)
echo To continue, type "I AGREE"
set /p agree=^> 
if not "%agree%"=="I AGREE" goto disclaimer
echo.
echo Would you like to add Schooi's Multitool to PATH (system32, so that you can access SMT from the command line)? (Y/N)
set /p 32=^> 
if "%32%"=="N" exit
cd /d ..
echo.
copy /y SchooiMultitool.bat "C:\Windows\system32\SchooiMultitool.bat" >nul
cd /d C:\Windows\System32
break>SMT.bat
echo @echo off >> SMT.bat
echo start SchooiMultitool %%1 >> SMT.bat
echo exit >> SMT.bat
cd /d %~dp0
cd ..
IF NOT EXIST "C:\Windows\system32\Files" md "C:\Windows\system32\Files" 
xcopy /y "Files" "C:\Windows\system32\Files\" /s /q >nul
if ERRORLEVEL 0 echo Success!
if NOT ERRORLEVEL 0 echo Error!
pause >nul
exit