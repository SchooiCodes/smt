@echo off
cd %~dp0
title Schooi's Multitool
fltmc >nul 2>&1 || (
    echo( && echo   [33m# Administrator privileges are required. && echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause && exit 1
    )
    exit 0
)
:disclaimer
cd %~dp0
cls
call logo.bat
cd ..
echo.
echo This doesn't work well on USBs!
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
set scriptpath=%~dp0
cd %scriptpath%
cd ..
echo Current Directory: %cd%
echo Type f when prompted
pause
xcopy /y SchooiMultitool.bat "C:\Windows\system32\SchooiMultitool.bat"
cd C:\Windows\System32
break>SMT.bat
echo @echo off >> SMT.bat
echo start SchooiMultitool %%1 >> SMT.bat
echo exit >> SMT.bat
cd %scriptpath%
cd ..
IF NOT EXIST "C:\Windows\system32\Files" md "C:\Windows\system32\Files"
xcopy /y "Files" "C:\Windows\system32\Files\" /s
pause >nul
exit