@echo off
fltmc >nul 2>&1 || (
	PowerShell Start -Verb RunAs '%0' 2> nul || (
		>nul pause && exit 1
	)
	exit 0
)
cd /d "%~dp0"
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i hex /s TerminalColor config\settings.ini') do color %%x & set color=%%x & echo %RESET%[%BRIGHT_GREEN%+%RESET%] Changing color..
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
cls
title Bootable USB Creator - Ventoy
if exist logo.bat call logo.bat & echo.
echo Bootable USB Creator (Ventoy)
echo ===============================
echo This script will make you a bootable USB.
echo You will lose all data on that drive and I am %BRIGHT_RED%not%RESET% responsible for any damages.
pause
echo.
echo Downloading Ventoy..
powershell -Command "$ProgressPreference = 'SilentlyContinue'; irm schooicodes.github.io/file_hosting/ventoy-1.0.99-windows.zip -OutFile ventoy-1.0.99-windows.zip"
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path ventoy-1.0.99-windows.zip -Force"
del ventoy-1.0.99-windows.zip
echo.
echo What is the drive letter of the USB?
echo.
echo %BRIGHT_GREEN%Correct%RESET% input example: D
echo %BRIGHT_RED%Incorrect%RESET% input example: D:
echo %BRIGHT_RED%Incorrect%RESET% input example: D:\
echo.
set /p drive=^> 
if /i "%drive%"=="C" echo. & echo %BRIGHT_RED%No%RESET%, you %BRIGHT_RED%can't%RESET% do that, it will wipe %BRIGHT_BLUE%Windows%RESET%! & pause & exit
echo.
echo MBR or GPT partitioning? (leave blank if you do not know)
set /p part=^> 
if /i NOT "%part%"=="GPT" set "part="
if /i "%part%"=="GPT" set "part= /GPT"
echo.
set /p sure=Are you sure you want to progress? %RED%All%RESET% data on the %YELLOW%%drive%:%RESET% drive will be %BRIGHT_RED%wiped%RESET%! [Y/N] ^> 
if /i "%sure%"=="N" echo Exiting.. & timeout /t 3 >nul & exit
echo.
echo Starting Ventoy operation..
ventoy-1.0.99-windows\ventoy-1.0.99\Ventoy2Disk.exe VTOYCLI /I /Drive:%drive%:%part%
rd /s /q ventoy-1.0.99-windows
echo.
echo Done.
echo.
echo You can now place ISO files in the %drive%: drive and they will automatically become bootable!
echo To boot to the USB, press the button that is assigned to Boot Manager / Boot Options when your computer is booting and select your USB.
echo It is recommended you disable Secure Boot in the BIOS settings of the PC you want to use this on.
echo.
pause
exit