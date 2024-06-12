@echo off
title Right Click Menu Changer
call logo.bat
echo.
echo Hello! This is the right-click menu changer!
echo Would you like to read the instructions? Type Y for Yes and N for No.
set /p inst="[Y/N]: "
if /i "%inst%"=="Y" goto :Y 
if /i "%inst%"=="N" goto :Start

:Start 
echo.
echo Would you like to have the old right-click menu or the Windows 11 one?
echo Type O for old, and N for new.
set /p menu="[O/N]: "
if /i "%menu%"=="O" goto :O
if /i "%menu%"=="N" goto :N
echo Invalid choice.
goto :EOF

:O
echo Adding required registry values...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
echo Done.
reg query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
echo Done.
if NOT %ERRORLEVEL% EQU 0 echo Something went wrong!

echo Killing explorer...
taskkill /f /im explorer.exe
echo Done.

echo Restarting explorer...
start explorer.exe
echo Done.
pause
goto :EOF

:N
echo Deleting required registry values...
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
echo Done.

reg query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
reg query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
echo Done.
if ERRORLEVEL 0 echo Something went wrong!

echo Killing explorer...
taskkill /f /im explorer.exe
echo Done.

echo Restarting explorer...
start explorer.exe
echo Done.
pause
goto :EOF

:Y
call "Read Me.txt"
goto :Start
