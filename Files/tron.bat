@echo off
cd /d "%~dp0"
title Tron - SMT
if exist logo.bat call logo.bat & echo.
echo THIS SCRIPT WILL AUTOMATICALLY RUN TRON.
echo YOUR COMPUTER WILL AUTOMATICALLY RESTART.
echo PLEASE CLOSE ALL APPS BEFORE PROCEEDING.
echo RUNNING TRON CAN TAKE FROM 3 TO 10 HOURS.
echo.
echo IMPORTANT: Your antivirus may flag Tron's files.
echo If that happens, disable Real Time Protection, and run this tool again.
echo Recommended action: disable it right now.
echo.
echo Press any key to proceed..
pause >nul
echo.
echo Downloading Tron via self-extracting exe..
powershell -Command "$ProgressPreference = 'SilentlyContinue'; irm 'https://bmrf.org/repos/tron/Tron v12.0.8 (2025-01-09).exe' -OutFile 'tron.exe'" 
echo Extracting Tron's files..
start /MIN /WAIT "" "tron.exe"
cd "tron"
echo Checking for pre-existing desktop files..
if exist "%USERPROFILE%\Desktop\tron.bat" echo "%USERPROFILE%\Desktop\tron.bat" already exists. Renaming to tron.bat.old.. & ren "%USERPROFILE%\Desktop\tron.bat" tron.bat.old >nul
if exist "%USERPROFILE%\Desktop\resources" echo "%USERPROFILE%\Desktop\resources" already exists. Renaming to resources_old.. & ren "%USERPROFILE%\Desktop\resources" resources_old >nul
echo Moving tron.bat..
move tron.bat "%USERPROFILE%\Desktop\" >nul
echo Moving resources..
move resources "%USERPROFILE%\Desktop\" >nul
echo Adding startup entry for tron..
copy /y "%~dp0runtron.bat" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" >nul
echo Copying instructions..
copy /y "Instructions -- YES ACTUALLY READ THEM.txt" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" >nul
echo Cleaning up..
cd ..
del "tron.exe" >nul
rd /s /q tron >nul
rd /s /q integrity_verification >nul
echo Restarting..
shutdown -r -t 0
pause
exit