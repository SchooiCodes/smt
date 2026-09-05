@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd "%USERPROFILE%\Desktop"
if exist tron.bat tron -a -x -r
if NOT exist tron.bat del "%~f0" & exit
pause
exit