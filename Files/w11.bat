@echo off
title Windows 11 Tweaker
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul') do set build=%%a

if NOT %build% GEQ 22000 if exist logo.bat call logo.bat & echo. & echo This script is meant for Windows 11 only! Exiting.. & timeout /t 3 /NOBREAK >nul & exit

:menu
cls
if exist logo.bat call logo.bat & echo.
echo ==============================
echo     Windows 11 Tweaker
 echo ==============================
echo 1) Bring back old Desktop context menu
echo 2) Remove UWP explorer ribbon
echo 3) Bring back Windows 10 taskbar (NOT RECOMMENDED)
echo 4) Disable search
echo 5) Disable task grouping
echo 6) Enable small taskbar icons
echo 7) Disable rounded window corners (run again to revert)
echo 8) Revert past changes
echo.
set /p choices="Enter choices separated by spaces (e.g., 1 3 5): "
setlocal enabledelayedexpansion
for %%i in (%choices%) do (
    if %%i LSS 1 (echo Invalid input: %%i & timeout /t 3 /NOBREAK >nul & goto menu)
    if %%i GTR 8 (echo Invalid input: %%i & timeout /t 3 /NOBREAK >nul & goto menu)
)
echo Windows Registry Editor Version 5.00 > tweaks.reg
echo Logging changes to tweak_log.txt...
for %%i in (%choices%) do (
    if %%i==1 echo [HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]>> tweaks.reg & echo Old Desktop Context Menu applied.>> tweak_log.txt
    if %%i==2 echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]>> tweaks.reg & echo "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"="" >> tweaks.reg & echo UWP Explorer Ribbon Removed.>> tweak_log.txt
    if %%i==3 echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell\Update\Packages]>> tweaks.reg & echo "UndockingDisabled"=dword:00000001 >> tweaks.reg & echo Windows 10 Taskbar applied.>> tweak_log.txt
    if %%i==4 echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]>> tweaks.reg & echo "SearchboxTaskbarMode"=dword:00000000 >> tweaks.reg & echo Search disabled.>> tweak_log.txt
    if %%i==5 echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> tweaks.reg & echo "NoTaskGrouping"=dword:00000001 >> tweaks.reg & echo Task Grouping disabled.>> tweak_log.txt
    if %%i==6 echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> tweaks.reg & echo "TaskbarSmallIcons"=dword:00000001 >> tweaks.reg & echo Small Taskbar Icons enabled.>> tweak_log.txt
	if %%i==7 powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://schooicodes.github.io/file_hosting/Win11DisableOrRestoreRoundedCorners.exe -OutFile %temp%\bboc.exe" & start "" "%TEMP%\bboc.exe" & echo Old Corners enabled.>> tweak_log.txt
    if %%i==8 goto revert
)
echo.
set /p confirm="Apply selected tweaks? (Y/N): "
if /I not "%confirm%"=="Y" goto menu
reg import tweaks.reg
echo Tweaks applied successfully! >> tweak_log.txt
powershell -command "gps explorer | spps"
echo Explorer restarted. >> tweak_log.txt
echo.
timeout /t 3 >nul
del tweaks.reg
goto menu

:revert
echo Reverting changes...
(echo Windows Registry Editor Version 5.00 > revert.reg
 echo [-HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]>> revert.reg
 echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]>> revert.reg
 echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell\Update\Packages]>> revert.reg & echo "UndockingDisabled"=dword:00000000 >> revert.reg
 echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]>> tweaks.reg & echo "SearchboxTaskbarMode"=dword:00000001 >> revert.reg
 echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> revert.reg & echo "NoTaskGrouping"=dword:00000000 >> revert.reg
 echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> revert.reg & echo "TaskbarSmallIcons"=dword:00000000 >> revert.reg)

reg import revert.reg
echo All tweaks reverted successfully! >> tweak_log.txt
echo taskkill /f /im explorer.exe ^>nul ^&^& explorer ^& exit > re.bat
start "" "re.bat"
echo Explorer restarted. >> tweak_log.txt
timeout /t 3 >nul
del revert.reg
goto menu
