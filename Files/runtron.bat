@echo off
cd /d "%~dp0"
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
if exist "Instructions -- YES ACTUALLY READ THEM.txt" (
	echo Please read Tron's instructions carefully.
	echo You do not need to do anything, but you need to know what the script does.
	timeout /t 3 >nul
	start "" "Instructions -- YES ACTUALLY READ THEM.txt"
	pause
)
del "Instructions -- YES ACTUALLY READ THEM.txt"
cd "%USERPROFILE%\Desktop"
if exist tron.bat tron -a -x -r
if NOT exist tron.bat del "%~f0" & exit
pause
exit