@echo off
setlocal enabledelayedexpansion
if /I "%CD:~0,1%"=="C" goto elevate
if exist "C:\Program Files\Schooi's Multitool\" goto elevate
if exist "C:\Windows\System32\SchooiMultitool.bat" goto elevate

:start
title SMT ^| Uninstall
cd /d %~dp0
if exist Files\logo.bat call Files\logo.bat
if exist Files\logo.bat echo.
echo Would you like to uninstall Schooi's Multitool? ([Y]es/[N]o)
set /p confirmation=^> 
if /I not "%confirmation%"=="Y" exit
if /I "%CD:~0,1%"=="C" goto C
goto USB

:elevate
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
goto start

:C
cd /d "C:\Program Files\Schooi's Multitool\" & attrib -h -s needed_file.schm >nul & del needed_file.schm >nul & cd .. & rd /s /q "Schooi's Multitool >nul"
if exist "C:\Windows\System32\SchooiMultitool.bat" cd /d "C:\Windows\System32\" & del SchooiMultitool.bat >nul & rd /s /q Files >nul & del SMT.bat >nul
cd /d %~dp0
if not exist smt md smt >nul
for %%F in ("%~dp0*.*") do (echo %%F>>smt\files.txt)
for /R "%~dp0" /D %%S in (*) do (echo %%S>>smt\folders.txt)
for /F "tokens=* delims=" %%a in (smt\files.txt) do (if not "%%a"=="%~f0" move "%%a" smt\ >nul)
for /F "tokens=* delims=" %%a in (smt\folders.txt) do (move "%%a" smt >nul)
rd /s /q smt >nul
del "%~f0" >nul
if %ERRORLEVEL%==0 echo Success!
pause >nul
exit

:USB
if exist "C:\Program Files\Schooi's Multitool\" cd /d "C:\Program Files\Schooi's Multitool\" & attrib -h -s needed_file.schm >nul & del needed_file.schm >nul & cd .. & rd /s /q "Schooi's Multitool >nul"
if exist "C:\Windows\System32\SchooiMultitool.bat" cd /d "C:\Windows\System32\" & del SchooiMultitool.bat >nul & rd /s /q Files >nul & del SMT.bat >nul
cd /d %~dp0
if NOT "%cd%"=="%CD:~0,3%" cd .. & goto USB
attrib -h -s needed_file.schm
del needed_file.schm
if not exist smt md smt >nul
for %%F in ("%~dp0*.*") do (echo %%F>>smt\files.txt)
for /R "%~dp0" /D %%S in (*) do (echo %%S>>smt\folders.txt)
for /F "tokens=* delims=" %%a in (smt\files.txt) do (if not "%%a"=="%~f0" move "%%a" smt\ >nul)
for /F "tokens=* delims=" %%a in (smt\folders.txt) do (move "%%a" smt >nul)
rd /s /q smt >nul
del "%~f0" >nul
if %ERRORLEVEL%==0 echo Success!
pause >nul
exit