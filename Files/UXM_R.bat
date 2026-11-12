@echo off
fltmc >nul 2>&1 || (
	PowerShell Start -Verb RunAs '%0' 2> nul || (
		>nul pause && exit 1
	)
	exit 0
)
REM made by schooi (gh: schooicodes)
REM contains manual operations to disinfect PCs from the u* xm injection miner
REM dev start: 30/10/2025
color 0f
title U* XMRig Virus Removal ^| v1.3
call :logo
echo %TIME% [Console] ^| Start
echo %TIME% [Console] ^| Checking Windows installation..
if not exist "C:\Windows\System32\wsvcz" echo %TIME% [Console] ^| Device seems clean, checking USB drives.. & goto usb
echo %TIME% [Warning] ^| Device seems infected, initiating removal..
cd "C:\Windows\System32"
for /f %%a in ('dir %SystemRoot%\System32\u??????.dll /b ^| findstr /R /C:"^u[0-9][0-9][0-9][0-9][0-9][0-9]\.dll$"') do set "serv=%%a"
echo %TIME% [Console] ^| Stopping service "%serv:~0,-4%"..
sc stop %serv:~0,-4% >nul
echo %TIME% [Console] ^| Deleting service "%serv:~0,-4%"..
sc delete %serv:~0,-4% >nul
set /p "delconf=%TIME% [Confirm] | Delete "%serv%"? ([Y]es/[N]o) > "
if /i "%delconf%"=="n" echo %TIME% [Warning] ^| Aborting.. & pause & exit
echo %TIME% [Console] ^| Deleting "%serv%"..
del /f /q %serv%
if exist "C:\Windows\System32\wsvcz" cd /d "C:\Windows\System32\wsvcz"
setlocal enabledelayedexpansion
for /f "delims=" %%a in ('dir /b u*.exe 2^>nul') do set "exe_name=%%a"
set /p "delconf=%TIME% [Confirm] | Delete "%exe_name%"? ([Y]es/[N]o) > "
if /i "%delconf%"=="n" echo %TIME% [Warning] ^| Aborting.. & pause & exit
echo %TIME% [Console] ^| Killing "%exe_name%"..
taskkill /f /im %exe_name% >nul 2>&1
echo %TIME% [Console] ^| Deleting "%exe_name%"..
del %exe_name%
cd "C:\Windows\System32"
echo %TIME% [Console] ^| Removing infected folder (wsvcz)..
rd /s /q "C:\Windows\System32\wsvcz"
echo %TIME% [Console] ^| Removing injected sysfile (svctrl64)..
del "C:\Windows\System32\svctrl64.exe"
echo %TIME% [Console] ^| Finished Windows cleanup.
echo %TIME% [Console] ^| Checking USB Drives..

:usb
setlocal enabledelayedexpansion
set "letters=CDEFGHIJKLMNOPQRSTUVWXYZ"
for /L %%i in (0,1,23) do (
    set "letter=!letters:~%%i,1!"
    if exist "!letter!:\sysvolume" (
		echo %TIME% [Warning] ^| !letter!:\ seems infected, attempting automatic recovery..
		set "usb=true"
        for /f "usebackq delims=" %%N in (`dir /ad /b "!letter!:\"`) do (
			if exist "!letter!:\%%N.lnk" (
				for /f "tokens=1 delims= " %%a in ('attrib "!letter!:\%%N"') do echo %%a | find "SH" >nul 2>&1 && (
					echo %TIME% [Console] ^| Removing infected folder ^(sysvolume^)..
					rd /s /q "!letter!:\sysvolume" 
					echo %TIME% [Console] ^| Unhiding USB files..
					attrib -s -h "!letter!:\%%N" 
					echo %TIME% [Console] ^| Deleting shortcut remnant.. & del /q "!letter!:\%%N.lnk"
				) || (
					echo %TIME% [Warning] ^| "!letter!:\%%N" doesn't match SH attrib tests, please consult the creator of this script.
				)
			)
        )
    )
)
if NOT "%usb%"=="true" echo %TIME% [Console] ^| USB Drives seem clean, exiting..
echo %TIME% [Console] ^| Finished.
echo %TIME% [Console] ^| Press any key to exit..
pause >nul
endlocal
exit

:logo
for /f "tokens=2,*delims=:" %%i in ('chcp') do set /a oldcp=%%i
chcp 65001 >nul
echo ██╗   ██╗██╗  ██╗███╗   ███╗        ██████╗  U* XMRig Injection Miner Remover
echo ██║   ██║╚██╗██╔╝████╗ ████║        ██╔══██╗ Made by SchooiCodes
echo ██║   ██║ ╚███╔╝ ██╔████╔██║        ██████╔╝ https://github.com/SchooiCodes/uxm_r
echo ██║   ██║ ██╔██╗ ██║╚██╔╝██║        ██╔══██╗
echo ╚██████╔╝██╔╝ ██╗██║ ╚═╝ ██║███████╗██║  ██║
echo  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
chcp %oldcp% >nul