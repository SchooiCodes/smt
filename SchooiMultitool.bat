@echo off
cls
set vnum=2.2
set version=v%vnum%
if "%~dp0"=="C:\Windows\System32\" cd C:\Windows\System32\
if "%~dp0"=="C:\Program Files\Schooi's Multitool\" cd "C:\Program Files\Schooi's Multitool\"
cd Files
FOR /F "tokens=* delims=" %%x in (color.txt) DO color %%x
set old_dir = %~dp0\Files
set scriptpath=%cd%

:pcheck
REM Anti-Piracy
if "%CD:~0,3%"=="C:\" if exist "C:\Program Files\Schooi's Multitool\needed_file.schm" goto rpoint
if exist "%CD:~0,2%\needed_file.schm" goto rpoint
if exist "setup.bat" goto setup
goto pirated

:setup
title [SMT ^| %version%] Setup
call logo.bat
echo ===============================
echo First time running, setup needed...
start setup.bat
pause >nul
cls
goto pcheck

:rpoint
title [SMT ^| %version%] Restore Point
cls
call logo.bat
echo.
echo I, Schooi, am NOT responsible for any damage caused by this program. 
set /p rpoint=Would you like to create a system restore point? (Y/N): 
if /i "%rpoint%"=="Y" start autorespo.bat
cls

:start
title SMT ^| %version%
cls
call logo.bat
echo ---------------------------
echo Schooi's Multitool ^| %version%
echo ---------------------------
echo Hello, %username%. What would you like to do?
echo 1. Go to the tools
echo 2. Go to the advanced tools
echo 3. Edit this script
echo 4. Restart this script (to apply changes)
echo 5. View info about this script
echo.
set /p choice=%username%@smt:~$ 
if /i "%choice%"=="1" goto Tools
if /i "%choice%"=="2" goto AdvancedTools
if /i "%choice%"=="3" (cd .. & notepad.exe "SchooiMultitool.bat" & cd "Files") & goto start
if /i "%choice%"=="4" start restart.bat & exit
if /i "%choice%"=="5" goto info
if /i "%choice%"=="%username%On" @echo on & goto start
if /i "%choice%"=="%username%Off" @echo off & goto start
if /i "%choice%"=="sc" goto secrets
if /i "%choice%"=="pf" start pf & goto start
if /i "%choice%"=="32" start s32 & goto start
if /i "%choice%"=="99" goto history
if /i "%choice%"=="cl" goto color 
if /i "%choice%"=="shutdown" shutdown -s -t 0
if /i "%choice%"=="restart" shutdown -r -t 0
if /i "%choice%"=="bios" shutdown -r -fw -t 0
if /i "%choice%"=="git" start https://github.com/SchooiCodes/smt/releases & goto start
if /i "%choice%"=="vc" goto vc
if NOT "%choice%"=="" %choice%
if %ERRORLEVEL% EQU 0 pause >nul
goto start

:tools
cls
call logo.bat
title [SMT ^| %version%] Tools
echo.
echo Choose a tool:
echo -----------
echo 1. Go Back
echo 2. Exit
echo -----------
echo 3. Password Generator
echo 4. Right Click Menu Changer
echo 5. Command-Line Game
echo 6. Scan Computer for Errors
echo 7. Create A System Restore Point (Recommended, do this before using any other tool)
echo 8. URL Shortener
echo 9. View this system's info
echo 10. Enable/Disable Hibernation
echo 11. Folder Organizer
echo 12. ASCII(/ANSI) Art Generator
echo.
set /p ch=%username%@smt:~$ 
if "%ch%"=="1" cls & goto start
if "%ch%"=="2" goto end
if "%ch%"=="3" start PasswordGenerator.bat
if "%ch%"=="4" start rcmc.bat
if "%ch%"=="5" start CommandLineGame.bat
if "%ch%"=="6" start suc.bat
if "%ch%"=="7" start autorespo.bat
if "%ch%"=="8" start URLShortener.bat
if "%ch%"=="9" start sysinfo.bat
if "%ch%"=="10" start hibern.bat
if "%ch%"=="11" start fo.bat
if "%ch%"=="12" start ascii.bat
if "%ch%"=="cd" echo %cd% & pause >nul
set "%ch%"="nul"
cls
goto Tools

:advancedtools
title [SMT ^| %version%] Advanced Tools
cls
call logo.bat
echo.
echo Choose a tool:
echo -----------
echo 1. Go Back
echo 2. Exit
echo -----------
echo 3. Apps
echo 4. Danger Zone
echo 5. IP Tools
echo 6. Performance
echo 7. Fixes ^& Crackers
echo 8. .zip Password Cracker
echo 9. Text To Speech
echo 10. SMB Bruteforcer
echo 11. User Manager
echo 12. Schnuker
echo 13. Driver Backupper
echo 14. Batch File Creator
echo 15. Backup the Registry
echo 16. Import Registry Backups
echo 17. rockyou.txt Downloader
echo 18. CLI Task Manager
echo 19. Wi-Fi Password Shower
echo 20. Network Speedtest
echo 21. Website Blocker
echo ?. ???
echo.
set /p advch=%username%@smt:~$ 
if "%advch%"=="1" cls & goto start
if "%advch%"=="2" goto end
if "%advch%"=="3" goto Apps
if "%advch%"=="4" goto Danger
if "%advch%"=="5" goto IPTools
if "%advch%"=="6" goto Performance
if "%advch%"=="7" goto fac
if "%advch%"=="8" start zicrack.bat
if "%advch%"=="9" start speak.vbs
if "%advch%"=="10" start SMBBruteforcer.bat
if "%advch%"=="11" start RAUP.bat
if "%advch%"=="12" cd Schnuker & Installation.lnk & cd ..
if "%advch%"=="13" start db.bat
if "%advch%"=="14" start bfc.bat
if "%advch%"=="15" start BackupRegistry.bat
if "%advch%"=="16" start ImportBackups.bat
if "%advch%"=="17" start rockyou.bat
if "%advch%"=="18" start taskmanager.bat
if "%advch%"=="19" start wifipasses.bat
if "%advch%"=="20" start stcli.bat
if "%advch%"=="21" start hfb.bat
if "%advch%"=="22" start nsl.bat
if "%advch%"=="cd" echo %cd% & pause>nul
if "%advch%"=="?" start mystery.bat
cls
goto AdvancedTools


REM :1
REM cls
REM title SMT ^| %version%
REM call logo.bat
REM echo.
REM echo I am not responsible for any damage caused by this program. 
REM set /p rpoint=Would you like to create a system restore point? (Y/N): 
REM if /i "%rpoint%"=="Y" start autorespo.bat
REM cls

:apps
cls
call logo.bat
echo.
echo Apps
echo ====
echo Choose an app:
echo -----------
echo 1. Go Back
echo -----------
echo 2. SuperF4
echo 3. Geek Uninstaller
echo 4. Command Prompt
echo 5. Powershell
echo 6. Powershell 7
echo 7. Powershell (Installer for devices that don't have it)
echo 8. Fastfetch
echo 9. Git
echo 10. Winget
echo 11. Chris Titus Tool
echo 12. Wintoys
echo 13. Windows PC Manager
echo 14. f.lux
echo 15. Chrome
echo 16. Spotify (No Ads)
echo 17. Firefox
echo 18. 7zip
echo.
set /p appch=%username%@smt:~$ 
if "%appch%"=="1" cls & goto AdvancedTools
if "%appch%"=="2" start Apps\SuperF4.bat
if "%appch%"=="3" start Apps\geek.bat
if "%appch%"=="4" start cmd & cd %olddir%
if "%appch%"=="5" start Apps\powershell & cd %olddir%
if "%appch%"=="6" start Apps\ps7.bat
if "%appch%"=="7" start Apps\pswin7.bat
if "%appch%"=="8" start Apps\fastfetch.bat
if "%appch%"=="9" start Apps\git.bat
if "%appch%"=="10" start Apps\winget.bat
if "%appch%"=="11" start Apps\ctt.bat
if "%appch%"=="12" start Apps\wintoys.bat
if "%appch%"=="13" start Apps\pcm.bat
if "%appch%"=="14" start Apps\flux.bat
if "%appch%"=="15" start Apps\chrome.bat
if "%appch%"=="16" start Apps\bts.bat
if "%appch%"=="17" start Apps\firefox.bat
if "%appch%"=="18" start Apps\7z.bat
goto apps

:danger
cls
call logo.bat
echo.
echo Danger Zone
echo ===========
echo Choose a tool:
echo ----------------
echo 1. Go Back
echo ----------------
echo 2. Windows Destroyer
echo 3. Info Stealer
echo.
set /p dangch=%username%@smt:~$ 
if "%dangch%"=="1" cls & goto AdvancedTools
if "%dangch%"=="2" start WD.bat
if "%dangch%"=="3" start InfoFinder.bat
goto danger

:IPTools
cls
call logo.bat
echo.
echo IP Tools
echo ======
echo Choose a tool:
echo -----------
echo 1. Go Back
echo -----------
echo 2. IP Logger
echo 3. IP Geolocator
echo 4. IP Pinger
echo.
set /p ipch=%username%@smt:~$ 
if "%ipch%"=="1" cls & goto AdvancedTools
if "%ipch%"=="2" start IPLog.bat
if "%ipch%"=="3" start IPGeolocator.exe
if "%ipch%"=="4" start pinger.bat
goto IPTools

:Performance
cls
call logo.bat
echo.
echo Performance
echo ==========
echo Choose a tool:
echo ----------------
echo 1. Go Back
echo ----------------
echo 2. Windows Performance Options
echo 3. Chris Titus Tool
echo 4. Ultimate Performance Power Plan Enabler
echo.
set /p perfch=%username%@smt:~$ 
if "%perfch%"=="1" cls & goto AdvancedTools
if "%perfch%"=="2" start %windir%\system32\systempropertiesperformance.exe
if "%perfch%"=="3" start ctt.bat
if "%perfch%"=="4" start UPPPE.bat
goto Performance

:fac
cls
call logo.bat
echo.
echo Fixes ^& Crackers
echo ================
echo Choose a tool:
echo ----------------
echo 1. Go Back
echo ----------------
echo 2. Malwarebytes Premium Resetter
echo 3. "Some Settings Are Managed By Your Organization" Fixer
echo 4. Windows Activator
echo 5. Group Policy Editor Enabler
echo.
set /p facch=%username%@smt:~$ 
if "%facch%"=="1" cls & goto AdvancedTools
if "%facch%"=="2" start Malwarebyes-Premium-Reset.bat
if "%facch%"=="3" start SSAMBYO.bat
if "%facch%"=="4" start WA.bat
if "%facch%"=="5" start GPEE.bat
goto fac

:info
title [SMT ^| %version%] Info
cls
call logo.bat
echo.
echo Made by @schooi. on Discord (SchooiCodes on github)
echo ===================================
echo Currently in version %vnum%
echo Development started May 2024
echo It is currently %date%. Still open source! :D
echo Don't make changes and say this script is your own!
echo Also credit me if you use this for any social media!
echo Fun Fact: Almost all the tools are made by me!
echo.
echo https://github.com/SchooiCodes/smt
echo (c) Schooi 2024
pause >nul
goto start

:history
title [SMT ^| %version%] Command History
cls
call logo.bat
echo.
echo Command history
echo ============
doskey /history
pause >nul
goto start

:pirated
if exist setup.bat goto setup
title [SMT ^| %version%] Pirated!
call logo.bat
echo.
echo Don't pirate my scripts!
goto end

:rpoint
start autorespo.bat
goto start

:color
break>color.txt 
cls
call logo.bat
echo.
echo Would you like to change to the old color, the new color or go back? (O/N/GB)
echo You can also choose a custom color (check color /? in cmd), just leave the choice blank.
set /p cl=^> 
if /i "%cl%"=="O" color 07 & echo 07 >> color.txt & goto start
if /i "%cl%"=="N" color 0f & echo 07 >> color.txt  & goto start
if /i "%cl%"=="GB" goto start
set /p cc=Custom Color: 
echo %cc% >> color.txt
color %cc%
timeout 3 >nul
goto start

:secrets
cls
call logo.bat
echo.
echo Secret Commands:
echo %username%On - turns on debug mode
echo %username%Off - turns off debug mode
echo sc - goes here
echo 99 - command history
echo 32 - adds Schooi's Multitool to system32 (PATH)
echo pf - adds Schooi's Multitool to Program Files
echo cl - changes the output color
echo shutdown - shuts down your device
echo restart - restarts your device
echo bios - restarts to the bios
pause >nul
goto start

:elevate
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)

:end
exit
