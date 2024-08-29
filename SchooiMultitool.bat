@echo off
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
cd /d %~dp0
echo echo %~dp0 | findstr "Program Files" >nul
if %ERRORLEVEL% EQU 0 set found=true
echo echo %~dp0 | findstr "System32" >nul
if %ERRORLEVEL% EQU 0 set found=true
if "%1"=="-debug" @echo on
if "%1"=="--debug" @echo on
if "%1"=="-rp" start Files\autorespo.bat & exit
if "%1"=="--rp" start Files\autorespo.bat & exit
if "%1"=="-restore-point" start Files\autorespo.bat & exit
if "%1"=="--restore-point" start Files\autorespo.bat & exit
if "%1"=="-32" start Files\s32.bat & exit
if "%1"=="--32" start Files\s32.bat & exit
if "%1"=="-pf" start Files\pf.bat & exit
if "%1"=="--pf" start Files\pf.bat & exit
if "%1"=="-h" goto help
if "%1"=="--h" goto help
if "%1"=="-help" goto help
if "%1"=="--help" goto help
cls
set vnum=2.3
set version=v%vnum%
cd Files
call logo.bat
echo.
echo Starting SMT..
echo [~] Checking for updates...
powershell -Command "irm https://raw.githubusercontent.com/SchooiCodes/smt/main/Files/config/version -OutFile %TEMP%\version"
for /f "tokens=* delims=" %%a in (%TEMP%\version) do (
	if NOT "%%a"=="%version%" (
		echo [-] %%a update available! 
		choice /C YN /N /t 30 /D Y /M "[~] Would you like to install it now? [Y/N] " 
		if ERRORLEVEL 1 (
			if not exist "%TEMP%\smt" md "%TEMP%\smt" 
			copy /y NUL "%TEMP%\SMT\SkipMSGBox" >nul
			powershell -Command "irm -useb https://github.com/SchooiCodes/smt/raw/main/Schooi`'s%%20Multitool%%20Setup.exe -OutFile %TEMP%\SMTSetup.exe" 
			"%TEMP%\SMTSetup.exe"
			rd /s /q "%TEMP%\SMT" >nul
			echo [+] SMT was updated, please start the script again to continue.
			timeout /t 5 /NOBREAK >nul
			exit
			)
		)
	if "%%a"=="%version%" echo [+] SMT is up to date.
	)	
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i hex /s TerminalColor config\settings.ini') do color %%x & set color=%%x & echo %RESET%[%BRIGHT_GREEN%+%RESET%] Changing color..
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call :tc & echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring.. 
if %WINDOWSVER% LEQ 6 echo %RESET%[%BRIGHT_RED%-%RESET%] Windows version is not 10+, disabling text coloring.. & call ini.bat /i coloring /s TerminalTextColoring /v false config\settings.ini >nul & call :tcoff
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i resizing /s TerminalResizing config\settings.ini') do echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for automatic window resizing.. & set resizing=%%x
REM set old_dir=%~dp0\Files
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
echo.
echo Setup
echo ===============================
echo First time running, setup needed...
start setup.bat
pause >nul
cls
goto pcheck

:rpoint
if "%resizing%"=="true" mode con cols=75 lines=16
title [SMT ^| %version%] Restore Point
cls
call logo.bat
echo.
echo I, Schooi, am %BRIGHT_RED%NOT%RESET% responsible for any damage caused by this program. 
set /p rpoint=Would you like to create a %CYAN%system restore point%RESET%? (%BRIGHT_GREEN%Y%RESET%/%BRIGHT_RED%N%RESET%): 
if /i "%rpoint%"=="Y" start autorespo.bat
cls

:start
if "%resizing%"=="true" mode con cols=80 lines=24
FOR /F "tokens=* delims=" %%x in (config\color.ini) DO color %%x
title SMT ^| %version%
cls
call logo.bat
chcp 65001 >nul
echo %CYAN%┌────────────────────┬──────┬──────────────────┐%RESET%
echo %CYAN%│%RESET% Schooi's Multitool %CYAN%│%RESET% %version% %CYAN%│%RESET% Made by @schooi. %CYAN%│%RESET%
echo %CYAN%└────────────────────┴──────┴──────────────────┘%RESET%
echo Hello, %BRIGHT_BLUE%%username%%RESET%. What would you like to do?
echo 1. Go to the tools
echo 2. Go to the advanced tools
echo 3. Edit this script
echo 4. Restart this script (to apply any changes)
echo 5. View info about this script
echo.
set /p choice=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
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
if /i "%choice%"=="tcon" call ini.bat /i coloring /s TerminalTextColoring /v true config\settings.ini >nul & call :tc
if /i "%choice%"=="tcoff" call ini.bat /i coloring /s TerminalTextColoring /v false config\settings.ini >nul & call :tcoff
if /i "%choice%"=="mdon" call ini.bat /i resizing /s TerminalResizing /v true config\settings.ini >nul & set resizing=true & goto start
if /i "%choice%"=="mdoff" call ini.bat /i resizing /s TerminalResizing /v false config\settings.ini >nul & set resizing=false & mode con cols=120 lines=30 & goto start
if /i "%choice%"=="credits" goto credits
if NOT "%choice%"=="" %choice%
if %ERRORLEVEL% EQU 0 pause >nul
goto start

:tools
if "%resizing%"=="true" mode con cols=80 lines=33
cls
call logo.bat
title [SMT ^| %version%] Tools
echo.
echo Choose a tool:
echo %CYAN%┌────────────┐%RESET%
echo %CYAN%│%RESET% B. Go Back %CYAN%│%RESET%
echo %CYAN%│%RESET% E. Exit    %CYAN%│%RESET%
echo %CYAN%└────────────┘%RESET%
echo 1. Password Generator
echo 2. Right Click Menu Changer
echo 3. Command-Line Game
echo 4. Scan Computer for Errors
echo 5. Create A System Restore Point
echo 6. URL Shortener
echo 7. View this system's info
echo 8. Enable/Disable Hibernation
echo 9. Folder Organizer
echo 10. ASCII(/ANSI) Art Generator
echo 11. ASCII(/ANSI) Art Gradient Generator
echo 12. Credentials Storer
echo.
set /p ch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
if /i "%ch%"=="B" cls & goto start
if /i "%ch%"=="E" goto end
if "%ch%"=="1" start PasswordGenerator.bat
if "%ch%"=="2" start rcmc.bat
if "%ch%"=="3" start CommandLineGame.bat
if "%ch%"=="4" start suc.bat
if "%ch%"=="5" start autorespo.bat
if "%ch%"=="6" start URLShortener.bat
if "%ch%"=="7" start sysinfo.bat
if "%ch%"=="8" start hibern.bat
if "%ch%"=="9" start fo.bat
if "%ch%"=="10" start ascii.bat
if "%ch%"=="11" start gradients.bat
if "%ch%"=="12" start creds.bat
if "%ch%"=="cd" echo %cd% & pause >nul
set "%ch%"="nul"
cls
goto Tools

:advancedtools
if "%resizing%"=="true" mode con cols=80 lines=47
title [SMT ^| %version%] Advanced Tools
cls
call logo.bat
echo.
echo Choose a tool:
echo %CYAN%┌────────────┐%RESET%
echo %CYAN%│%RESET% B. Go Back %CYAN%│%RESET%
echo %CYAN%│%RESET% E. Exit    %CYAN%│%RESET%
echo %CYAN%└────────────┘%RESET%
echo 1. Apps
echo 2. Danger Zone
echo 3. IP Tools
echo 4. Performance
echo 5. Fixes ^& Crackers
echo 6. .zip Password Cracker
echo 7. Text To Speech
echo 8. SMB Bruteforcer
echo 9. User Manager
echo 10. Schnuker
echo 11. Driver Backupper
echo 12. Batch File Creator
echo 13. Backup the Registry
echo 14. Import Registry Backups
echo 15. rockyou.txt Downloader
echo 16. CLI Task Manager
echo 17. Wi-Fi Password Shower
echo 18. Network Speedtest
echo 19. Website Blocker
echo 20. NS Lookupper
echo 21. Internet Route Tracer
echo 22. UAC Disabler
echo 23. sethc Trick Applier
echo 24. Time Freezer
echo 25. Directory File Line Counter
echo 26. Google Extension Manifest V2 Extender
echo ?. ???
echo.
set /p advch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
if /i "%advch%"=="B" cls & goto start
if /i "%advch%"=="E" goto end
if "%advch%"=="1" goto Apps
if "%advch%"=="2" goto Danger
if "%advch%"=="3" goto IPTools
if "%advch%"=="4" goto Performance
if "%advch%"=="5" goto fac
if "%advch%"=="6" start zicrack.bat
if "%advch%"=="7" start speak.vbs
if "%advch%"=="8" start SMBBruteforcer.bat
if "%advch%"=="9" start RAUP.bat
if "%advch%"=="10" cd Schnuker & start install.bat & cd..
if "%advch%"=="11" start db.bat
if "%advch%"=="12" start bfc.bat
if "%advch%"=="13" start BR.bat
if "%advch%"=="14" start IB.bat
if "%advch%"=="15" start rockyou.bat
if "%advch%"=="16" start taskmanager.bat
if "%advch%"=="17" start wifipasses.bat
if "%advch%"=="18" start stcli.bat
if "%advch%"=="19" start hfb.bat
if "%advch%"=="20" start nsl.bat
if "%advch%"=="21" start trt.bat
if "%advch%"=="22" start uacd.bat
if "%advch%"=="23" start sct.bat
if "%advch%"=="24" start tf.bat
if "%advch%"=="25" start dflc.bat
if "%advch%"=="26" start exmv2ae.bat
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
if "%resizing%"=="true" mode con cols=80 lines=39
cls
call logo.bat
echo.
echo Apps
echo ====
echo Choose an app:
echo %CYAN%┌────────────┐%RESET%
echo %CYAN%│%RESET% B. Go Back %CYAN%│%RESET%
echo %CYAN%└────────────┘%RESET%
echo 1. SuperF4
echo 2. Geek Uninstaller
echo 3. Command Prompt
echo 4. Powershell
echo 5. Powershell 7
echo 6. Powershell (Installer for devices that don't have it)
echo 7. Fastfetch
echo 8. Git
echo 9. Winget
echo 10. Chris Titus Tool
echo 11. Wintoys
echo 12. Windows PC Manager
echo 13. f.lux
echo 14. Chrome
echo 15. Spotify (No Ads)
echo 16. Firefox
echo 17. 7zip
echo.
set /p appch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
if /i "%appch%"=="B" cls & goto AdvancedTools
if "%appch%"=="1" start Apps\SuperF4.bat
if "%appch%"=="2" start Apps\geek.bat
if "%appch%"=="3" start cmd & cd %olddir%
if "%appch%"=="4" start Apps\powershell & cd %olddir%
if "%appch%"=="5" start Apps\ps7.bat
if "%appch%"=="6" start Apps\pswin7.bat
if "%appch%"=="7" start Apps\fastfetch.bat
if "%appch%"=="8" start Apps\git.bat
if "%appch%"=="9" start Apps\winget.bat
if "%appch%"=="10" start Apps\ctt.bat
if "%appch%"=="11" start Apps\wintoys.bat
if "%appch%"=="12" start Apps\pcm.bat
if "%appch%"=="13" start Apps\flux.bat
if "%appch%"=="14" start Apps\chrome.bat
if "%appch%"=="15" start Apps\bts.bat
if "%appch%"=="16" start Apps\firefox.bat
if "%appch%"=="17" start Apps\7z.bat
goto apps

:danger
if "%resizing%"=="true" mode con cols=80 lines=25
cls
call logo.bat
echo.
echo Danger Zone
echo ===========
echo Choose a tool:
echo %CYAN%┌────────────┐%RESET%
echo %CYAN%│%RESET% B. Go Back %CYAN%│%RESET%
echo %CYAN%└────────────┘%RESET%
echo 1. Windows Destroyer
echo 2. Info Stealer
echo 3. Disk Space Filler
echo.
set /p dangch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
if /i "%dangch%"=="B" cls & goto AdvancedTools
if "%dangch%"=="1" start WD.bat
if "%dangch%"=="2" start InfoFinder.bat
if "%dangch%"=="3" start dsf.bat
goto danger

:IPTools
if "%resizing%"=="true" mode con cols=80 lines=25
cls
call logo.bat
echo.
echo IP Tools
echo ======
echo Choose a tool:
echo %CYAN%┌────────────┐%RESET%
echo %CYAN%│%RESET% B. Go Back %CYAN%│%RESET%
echo %CYAN%└────────────┘%RESET%
echo 1. IP Logger
echo 2. IP Geolocator
echo 3. IP Pinger
echo.
set /p ipch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
if /i "%ipch%"=="B" cls & goto AdvancedTools
if "%ipch%"=="1" start IPLog.bat
if "%ipch%"=="2" start IPGeolocator.exe
if "%ipch%"=="3" start pinger.bat
goto IPTools

:Performance
if "%resizing%"=="true" mode con cols=80 lines=25
cls
call logo.bat
echo.
echo Performance
echo ==========
echo Choose a tool:
echo %CYAN%┌────────────┐%RESET%
echo %CYAN%│%RESET% B. Go Back %CYAN%│%RESET%
echo %CYAN%└────────────┘%RESET%
echo 1. Windows Performance Options
echo 2. Chris Titus Tool
echo 3. Ultimate Performance Power Plan Enabler
echo.
set /p perfch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
if /i "%perfch%"=="B" cls & goto AdvancedTools
if "%perfch%"=="1" start %windir%\system32\systempropertiesperformance.exe
if "%perfch%"=="2" start apps\ctt.bat
if "%perfch%"=="3" start UPPPE.bat
goto Performance

:fac
if "%resizing%"=="true" mode con cols=80 lines=26
cls
call logo.bat
echo.
echo Fixes ^& Crackers
echo ================
echo Choose a tool:
echo %CYAN%┌────────────┐%RESET%
echo %CYAN%│%RESET% B. Go Back %CYAN%│%RESET%
echo %CYAN%└────────────┘%RESET%
echo 1. Malwarebytes Premium Resetter
echo 2. "Some Settings Are Managed By Your Organization" Fixer
echo 3. Windows Activator
echo 4. Group Policy Editor Enabler
echo.
set /p facch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%WHITE%$ 
if /i "%facch%"=="B" cls & goto AdvancedTools
if "%facch%"=="1" start Malwarebytes-Premium-Reset.bat
if "%facch%"=="2" start SSAMBYO.bat
if "%facch%"=="3" start WA.bat
if "%facch%"=="4" start GPEE.bat
goto fac

:info
if not "%found%"=="true" if not "%calced%"=="1" call :calctools
if "%resizing%"=="true" mode con cols=80 lines=26
title [SMT ^| %version%] Info
cls
call logo.bat
echo.
echo Made by %GREEN%@schooi.%RESET% on Discord (SchooiCodes on github)
echo %CYAN%=====================================================%RESET%
echo Currently in version %YELLOW%%vnum%%RESET%
echo Development started May 2024
echo It is currently %BRIGHT_RED%%date%%RESET%. Still open source! :D
echo Don't make changes and say this script is your own!
echo Also credit me if you use this for any social media!
if not "%found%"=="true" echo I had a lot of fun making this! (Yes, all %toolCount% tools)
echo Fun Fact: Almost all the tools are made by me! 
echo (Type "credits" in the main menu for credits)
echo.
echo https://github.com/SchooiCodes/smt
echo (c) Schooi 2024
pause >nul
goto start

:calctools
set calced=1
setlocal enabledelayedexpansion
dir /s | findstr "File(s)">>temp.txt
set lastLine=
set toolCount=
for /f "tokens=* delims=" %%a in (temp.txt) do set lastLine=%%a
for /f "tokens=1 delims= " %%b in ("!lastLine!") do set toolCount=%%b
del temp.txt
set /a toolcount=%toolCount%-1
echo %toolcount%>>toolnum.txt
endlocal
FOR /F "tokens=* delims=" %%x in (toolnum.txt) DO set toolcount=%%x
del toolnum.txt
goto info

:history
if "%resizing%"=="true" mode con cols=80 lines=45
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
if "%resizing%"=="true" mode con cols=80 lines=16
if "%CD:~0,3%"=="C:\" if exist "C:\Program Files\Schooi's Multitool\needed_file.schm" goto rpoint
if exist "%CD:~0,2%\needed_file.schm" goto rpoint
if exist "setup.bat" goto setup
title [SMT ^| %version%] Pirated!
call logo.bat
echo.
echo Don't pirate my scripts!
pause >nul
exit

:color
if "%resizing%"=="true" mode con cols=100 lines=26
set cl=
cls
call logo.bat
echo.
echo Current Color: %color%
echo Would you like to change to the %Bright_GREY%old%RESET% color, the %WHITE%new%RESET% color or go back? (O/N/GB)
echo You can also choose a custom color (check color /? in cmd), just leave the choice blank.
set /p cl=^> 
break>config\color.ini
if /i "%cl%"=="O" (
	color 07
	call ini.bat /i hex /s TerminalColor /v 07 config\settings.ini
	if exist config\ae.ini (
		set "WHITE=[97m"
		set "Black=[30m"
		set "Dark_Blue=[34m"
		set "YELLOW=[33m"
		set "Green=[32m"
		set "Cyan=[36m"
		set "Red=[31m"
		set "Purple=[35m"
		set "Dark_Purple=[38;5;57m"
		set "Orange=[33m"
		set "White=[37m"
		set "Grey=[90m"
		set "Bright_Blue=[94m"
		set "Bright_Green=[92m"
		set "Bright_Cyan=[96m"
		set "Bright_Red=[91m"
		set "Bright_Purple=[95m"
		set "Bright_Yellow=[93m"
		set "Bright_White=[97m"
		set "RESET=[0m"
		)
	set color=07
	goto start
	)
if /i "%cl%"=="N" (
	color 0f
	call ini.bat /i hex /s TerminalColor /v 0f config\settings.ini
	if exist config\ae.ini (
		set "WHITE=[97m"
		set "Black=[30m"
		set "Dark_Blue=[34m"
		set "YELLOW=[33m"
		set "Green=[32m"
		set "Cyan=[36m"
		set "Red=[31m"
		set "Purple=[35m"
		set "Dark_Purple=[38;5;57m"
		set "Orange=[33m"
		set "White=[37m"
		set "Grey=[90m"
		set "Bright_Blue=[94m"
		set "Bright_Green=[92m"
		set "Bright_Cyan=[96m"
		set "Bright_Red=[91m"
		set "Bright_Purple=[95m"
		set "Bright_Yellow=[93m"
		set "Bright_White=[97m"
		set "RESET=[97m"
		)
	set color=0f
	goto start
	)
if /i "%cl%"=="GB" goto start
set /p cc=Custom Color: 
call ini.bat /i hex /s TerminalColor /v %cc% config\settings.ini
color %cc%
set "WHITE="
set "Bright_GREY="
set "Bright_CYAN="
set "CYAN="
set "RESET="
timeout 3 >nul
goto start

:secrets
if "%resizing%"=="true" mode con cols=80 lines=30
cls
call logo.bat
echo.
echo Secret Commands:
echo %Bright_CYAN%%username%On%RESET% - turns on debug mode
echo %Bright_CYAN%%username%Off%RESET% - turns off debug mode
echo %Bright_CYAN%sc%RESET% - goes here
echo %Bright_CYAN%99%RESET% - command history
echo %Bright_CYAN%32%RESET% - adds Schooi's Multitool to system32 (PATH)
echo %Bright_CYAN%pf%RESET% - adds Schooi's Multitool to Program Files
echo %Bright_CYAN%cl%RESET% - changes the output color
echo %Bright_CYAN%tcon%RESET% - enables terminal text coloring
echo %Bright_CYAN%tcoff%RESET% - disables terminal text coloring
echo %Bright_CYAN%mdon%RESET% - enables automatic window resizing
echo %Bright_CYAN%mdoff%RESET% - disables automatic window resizing
echo %Bright_CYAN%shutdown%RESET% - shuts down your device
echo %Bright_CYAN%restart%RESET% - restarts your device
echo %Bright_CYAN%bios%RESET% - restarts to the bios
echo %Bright_CYAN%git%RESET% - opens the github page for this tool
echo %Bright_CYAN%credits%RESET% - shows credits for tools I did not make
pause >nul
goto start

:credits
if "%resizing%"=="true" mode con cols=80 lines=24
cls
call logo.bat
echo.
echo Credits:
echo %CYAN%Command Line Game%RESET% - %GREEN%CHM Tech%RESET%
echo %CYAN%SMB Bruteforcer%RESET% - %GREEN%ebola man%RESET%
echo %CYAN%Network Speedtest%RESET% - %GREEN%the test itself is by Ookla%RESET%
echo %CYAN%Chris Titus Tool%RESET% - %GREEN%Chris Titus%RESET%
echo %CYAN%Malwarebytes Premium Resetter%RESET% - %GREEN%Scut1ny%RESET%
echo %CYAN%Windows Activator%RESET% - %GREEN%massgravel%RESET%
echo %CYAN%Group Policy Editor Enabler%RESET% - %GREEN%majorgeeks.com%RESET%
echo %CYAN%Mystery (in advanced tools)%RESET% - %GREEN%the animation itself is by ascii.live%RESET%
echo %CYAN%INI File Reader (used for settings)%RESET% - %GREEN%rojo on StackOverflow %YELLOW%(%WHITE%https://bit.ly/3WAxCXz%YELLOW%)%RESET%
echo.
echo AI Generated:
echo %CYAN%Folder Organizer%RESET%
echo %CYAN%Clipboard Manager%RESET%
echo %CYAN%Screenshot Tool%RESET%
echo %CYAN%File Integrity Checker%RESET%
pause >nul
goto start

:elevate
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)

:tc
if %color%==07 (
	set "WHITE=[97m"
	set "Black=[30m"
	set "Dark_Blue=[34m"
	set "Green=[32m"
	set "Cyan=[36m"
	set "Red=[31m"
	set "YELLOW=[33m"
	set "Purple=[35m"
	set "Dark_Purple=[38;5;57m"
	set "Orange=[33m"
	set "White=[37m"
	set "Grey=[90m"
	set "Bright_Blue=[94m"
	set "Bright_Green=[92m"
	set "Bright_Cyan=[96m"
	set "Bright_Red=[91m"
	set "Bright_Purple=[95m"
	set "Bright_Yellow=[93m"
	set "Bright_White=[97m"
	set "RESET=[0m"
	)
if %color%==0f (
	set "WHITE=[97m"
	set "Black=[30m"
	set "Dark_Blue=[34m"
	set "Green=[32m"
	set "YELLOW=[33m"
	set "Cyan=[36m"
	set "Red=[31m"
	set "Purple=[35m"
	set "Dark_Purple=[38;5;57m"
	set "Orange=[33m"
	set "White=[37m"
	set "Grey=[90m"
	set "Bright_Blue=[94m"
	set "Bright_Green=[92m"
	set "Bright_Cyan=[96m"
	set "Bright_Red=[91m"
	set "Bright_Purple=[95m"
	set "Bright_Yellow=[93m"
	set "Bright_White=[97m"
	set "RESET=[97m"
	)
goto :EOF

:tcoff
set "WHITE="
set "Black="
set "Dark_Blue="
set "Green="
set "Cyan="
set "Red="
set "Purple="
set "Dark_Purple="
set "Orange="
set "YELLOW="
set "White="
set "Grey="
set "Bright_Blue="
set "Bright_Green="
set "Bright_Cyan="
set "Bright_Red="
set "Bright_Purple="
set "Bright_Yellow="
set "Bright_White="
set "RESET="
call ini.bat /i hex /s TerminalTextColoring /v false config\settings.ini
goto :EOF

:end
exit

:help
echo.
echo  Schooi's Multitool is a multitool created to compile many utilities that can be used by advanced Windows users.
echo.
echo  Arguments:
echo.
echo  -debug ,--debug           Enters debug mode
echo.
echo  -h, --h                   Prints this manual
echo  -help, --help
echo.
echo  -rp, --rp                 Creates a system restore point
echo  -restore-point            
echo  --restore-point
echo.
echo  -32, --32                 Adds SMT to the path
echo.
echo  -pf, --pf                 Adds SMT to program files and creates a shortcut on the desktop (old, use exe installer instead)
echo.
echo  Disclaimers:
echo.
echo  -There are secret commands you can access by typing "sc" in the main menu.
echo  -If any app installers or tools don't work, please contact me on github: https://github.com/SchooiCodes/smt/issues
echo.