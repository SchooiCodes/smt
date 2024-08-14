@echo off
title UAC Disabler
cd /d "%~dp0"
set arg=

if "%1"=="--revert" set arg=--revert

:elevate
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' %arg% 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)

:start
call logo.bat
echo.
echo UAC Disabler
echo =========
echo Disclaimer: This only disables UAC. To undo changes, goto cmd and run "%~dp0uacd.bat --revert"
echo Changing registry values:
if "%arg%"=="--revert" (
    echo HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System: ConsentPromptBehaviorAdmin [0 --^> 5]
    echo HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System: ConsentPromptBehaviorUser [0 --^> 3]
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f >nul
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d 3 /f >nul
    if %ERRORLEVEL% EQU 0 echo Success!
    if NOT %ERRORLEVEL% EQU 0 echo Error! [%ERRORLEVEL%]
    pause >nul
    exit
)
echo HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System: ConsentPromptBehaviorAdmin [5 --^> 0]
echo HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System: ConsentPromptBehaviorUser [3 --^> 0]
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d 0 /f >nul
if %ERRORLEVEL% EQU 0 echo Success!
if NOT %ERRORLEVEL% EQU 0 echo Error! [%ERRORLEVEL%]
pause >nul
exit
