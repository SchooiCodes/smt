@echo off
fltmc >nul 2>&1 || (
	PowerShell Start -Verb RunAs '%0' 2> nul || (
		>nul pause && exit 1
	)
	exit 0
)
cd /d "%~dp0"
title Bootable USB Creator - Ventoy
call logo.bat
echo.
echo Bootable USB Creator (Ventoy)
echo ===============================
echo This script will make you a bootable USB.
echo You will lose all data on that drive and I am [91mnot[0m responsible for any damages.
pause
echo.
echo Downloading Ventoy..
powershell -Command "$ProgressPreference = 'SilentlyContinue'; irm schooicodes.github.io/file_hosting/ventoy-1.0.99-windows.zip -OutFile ventoy-1.0.99-windows.zip"
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path ventoy-1.0.99-windows.zip -Force"
del ventoy-1.0.99-windows.zip
echo.
echo What is the drive letter of the USB?
echo.
echo [92mCorrect[0m input example: D
echo [91mIncorrect[0m input example: D:
echo [91mIncorrect[0m input example: D:\
echo.
set /p drive=^> 
if /i "%drive%"=="C" echo. & echo [91mNo[0m, you [91mcan't[0m do that, it will wipe [96mWindows[0m! & pause & exit
echo.
echo MBR or GPT partitioning? (leave blank if you do not know)
set /p part=^> 
if /i NOT "%part%"=="GPT" set "part="
if /i "%part%"=="GPT" set "part= /GPT"
echo.
set /p sure=Are you sure you want to progress? [32mAll[0m data on the [33m%drive%:[0m drive will be [91mwiped[0m! [Y/N] ^> 
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