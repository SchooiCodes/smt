@echo off
7z >nul 2>&1
if NOT %ERRORLEVEL% EQU 0 goto 7z
goto check

:check
if /I "%CD:~0,1%"=="C" goto elevate

:start
cd %~dp0
title SMT ^| Setup
call :logo
echo.
echo Disclaimer:
echo Schooi's Multitool (otherwise known as "SMT") is provided for ethical purposes only. The creators and contributors of this tool do not condone, support, or endorse any illegal or unethical activities. The use of this tool for unauthorized access to computer systems, networks, or data is strictly prohibited and may violate local, national, and international laws.
echo By accessing, downloading, or using this tool, you agree to use it responsibly and lawfully. You acknowledge that any misuse of this tool, including but not limited to unauthorized access, data theft, or disruption of services, may result in legal consequences and civil liability.
echo The creators and contributors of this tool shall not be held responsible for any misuse or illegal activity conducted by users. Users are solely responsible for their actions and are encouraged to use this tool in accordance with ethical hacking principles and applicable laws.
echo This tool is provided "as is" without any warranty of any kind, express or implied. The creators and contributors make no representations or warranties regarding the accuracy, reliability, or suitability of the tool for any purpose.
echo By using this tool, you agree to indemnify and hold harmless the creators and contributors from any claims, damages, losses, liabilities, or expenses arising out of or in connection with your use of the tool.
echo Type "I AGREE" to continue.
set /p agree=^> 
if /I "%agree%" NEQ "I AGREE" exit
echo.
echo Choose an installation directory (default: %USERPROFILE%\Desktop\smt\, leave blank for default):
set /p installdir=^> 
if "%installdir%"=="" set installdir=%USERPROFILE%\Desktop\
goto clone

:clone
if NOT exist "%installdir%" md "%installdir%"
cd /d "%installdir%"
if NOT %ERRORLEVEL% EQU 0 echo Error! Incorrect install directory! & pause >nul & goto start
if exist smt rd /s /q smt
echo Downloading...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/SchooiCodes/smt/archive/refs/heads/main.zip' -OutFile '%USERPROFILE%\Downloads\smt.zip'"
echo Extracting..
7z x "%USERPROFILE%\Downloads\smt.zip" -o%installdir%
echo Cleaning up...
del /s /q "%USERPROFILE%\Downloads\smt.zip"
ren smt-main smt
cd /d smt
del Installer.bat
del README.md
del /s /q .git
rd /s /q .git
cd /d Files
del setup.bat
if /I "%CD:~0,1%"=="C" goto C
goto USB

:elevate
title Elevation Required
call :logo
echo.
echo Elevation Required
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)
cls
goto start

:C
cd /d "C:\Program Files"
md "Schooi's Multitool" 2>nul
cd "Schooi's Multitool"
copy /y NUL needed_file.schm >NUL
attrib +h +s needed_file.schm
del "%~f0"
exit

:USB
if NOT "%cd%"=="%CD:~0,3%" cd .. & goto USB
copy /y NUL needed_file.schm >NUL 
attrib +h +s needed_file.schm
del "%~f0"
exit

:7z
goto elevate
echo Installing 7zip...
powershell irm https://raw.githubusercontent.com/SchooiCodes/file_hosting/main/7z.ps1 | iex
goto start

:logo
for /f "tokens=2,*delims=:" %%i in ('chcp') do set /a oldcp =%%i
chcp 65001 >nul
echo/░██████╗░█████╗░██╗░░██╗░█████╗░░█████╗░██╗██╗░██████╗
echo/██╔════╝██╔══██╗██║░░██║██╔══██╗██╔══██╗██║╚█║██╔════╝
echo/╚█████╗░██║░░╚═╝███████║██║░░██║██║░░██║██║░╚╝╚█████╗░
echo/░╚═══██╗██║░░██╗██╔══██║██║░░██║██║░░██║██║░░░░╚═══██╗
echo/██████╔╝╚█████╔╝██║░░██║╚█████╔╝╚█████╔╝██║░░░██████╔╝
echo/╚═════╝░░╚════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░░░╚═════╝░
echo/
echo/███╗░░░███╗██╗░░░██╗██╗░░░░░████████╗██╗████████╗░█████╗░░█████╗░██╗░░░░░
echo/████╗░████║██║░░░██║██║░░░░░╚══██╔══╝██║╚══██╔══╝██╔══██╗██╔══██╗██║░░░░░
echo/██╔████╔██║██║░░░██║██║░░░░░░░░██║░░░██║░░░██║░░░██║░░██║██║░░██║██║░░░░░
echo/██║╚██╔╝██║██║░░░██║██║░░░░░░░░██║░░░██║░░░██║░░░██║░░██║██║░░██║██║░░░░░
echo/██║░╚═╝░██║╚██████╔╝███████╗░░░██║░░░██║░░░██║░░░╚█████╔╝╚█████╔╝███████╗
echo/╚═╝░░░░░╚═╝░╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░╚════╝░░╚════╝░╚══════╝
chcp %oldcp% >nul
