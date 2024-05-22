@echo off
set old_dir=%CD%
if /I "%CD:~0,1%"=="C" goto elevate

:start
title SMT ^| Setup
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
if exist "C:\Program Files\Schooi's Multitool\" cd /d "C:\Program Files\Schooi's Multitool\" & attrib -h -s needed_file.schm & del needed_file.schm & del SchooiMultitool.bat & rd /s /q Files
if exist "C:\Windows\System32\SchooiMultitool.bat" cd /d "C:\Windows\System32\" & del SchooiMultitool.bat & rd /s /q Files & del SMT.bat
cd %old_dir%
del SchooiMultitool.bat
rd /s /q Files
del "%~f0"
pause
exit

:USB
if exist "C:\Program Files\Schooi's Multitool\" cd /d "C:\Program Files\Schooi's Multitool\" & attrib -h -s needed_file.schm & del needed_file.schm & del SchooiMultitool.bat & rd /s /q Files
if exist "C:\Windows\System32\SchooiMultitool.bat" cd /d "C:\Windows\System32\" & del SchooiMultitool.bat & rd /s /q Files & del SMT.bat
cd %old_dir%
if NOT "%cd%"=="%CD:~0,3%" cd .. & goto USB
attrib -h -s needed_file.schm
del needed_file.schm
cd %old_dir%
cd ..
del SchooiMultitool.bat
rd /s /q Files
del "%~f0"
exit