@echo off
set elevate=true
cd /d %~dp0
set found=false
echo echo %~dp0 | findstr "Program Files" >nul
if %ERRORLEVEL% EQU 0 set found=true
echo echo %~dp0 | findstr "System32" >nul
if %ERRORLEVEL% EQU 0 set found=true
if "%1"=="-d" @echo on
if "%1"=="/d" @echo on
if "%1"=="--debug" @echo on
if "%1"=="/debug" @echo on
if "%1"=="-rp" start Files\autorespo.bat & exit
if "%1"=="/rp" start Files\autorespo.bat & exit
if "%1"=="--restore-point" start Files\autorespo.bat & exit
if "%1"=="/restore-point" start Files\autorespo.bat & exit
if "%1"=="-na" set elevate=false
if "%1"=="/na" set elevate=false
if "%1"=="--noadmin" set elevate=false
if "%1"=="/noadmin" set elevate=false
if "%1"=="-32" start Files\s32.bat & exit
if "%1"=="/32" start Files\s32.bat & exit
if "%1"=="--system32" start Files\s32.bat & exit
if "%1"=="/system32" start Files\s32.bat & exit
if "%1"=="-pf" start Files\pf.bat & exit
if "%1"=="/pf" start Files\pf.bat & exit
if "%1"=="--program-files" start Files\pf.bat & exit
if "%1"=="/program-files" start Files\pf.bat & exit
if "%1"=="-h" goto help
if "%1"=="/h" goto help
if "%1"=="--help" goto help
if "%1"=="/help" goto help
REM if "%1"=="-hide" set "github=."
REM if "%1"=="--hide" set "github=."
cls
set vnum=2.3
set version=v%vnum%
cd Files
call logo.bat
echo.
echo Starting SMT..
set "admin_needed=false"
if "%elevate%"=="true" (
	if "%found%"=="true" (
		set "admin_needed=true"
		fltmc >nul 2>&1 || (
			echo %RESET%[%BRIGHT_RED%-%RESET%] SMT is installed in an admin folder! Restarting as admin..
			PowerShell Start -Verb RunAs '%0' %* 2> nul || (
				>nul pause && exit 1
			)
			exit 0
		)
		echo %RESET%[%BRIGHT_GREEN%+%RESET%] SMT is installed in an admin folder, but is already running as admin. Continuing..
	)
	if "%found%"=="false" echo %RESET%[%BRIGHT_GREEN%+%RESET%] SMT is not installed in an admin folder, continuing without escalation..	
	set found=false
)
net session >nul 2>&1 && set "elevated=true" || set "elevated=false"
echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Fetching OS info..
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| find "ProductName"') do set "ProductName=%%b"
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| find "CurrentBuild"') do set "CurrentBuild=%%b"
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion ^| find "DisplayVersion"') do set "DisplayVersion=%%b"
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v UBR ^| find "UBR"') do set "UBR=%%b"
if %CurrentBuild% GEQ 22000 set "ProductName=%ProductName:Windows 10=Windows 11%
cscript C:\Windows\System32\slmgr.vbs /xpr | find "The machine is permanently activated." >nul
if %ERRORLEVEL% EQU 0 (set "win_activated=true") ELSE (set "win_activated=false")
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i hex /s TerminalColor config\settings.ini') do color %%x & set color=%%x & echo %RESET%[%BRIGHT_GREEN%+%RESET%] Changing color..
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring.. 
if %WINDOWSVER% LEQ 6 echo [-] Windows version is not 10+, disabling text coloring.. & call ini.bat /i coloring /s TerminalTextColoring /v false config\settings.ini >nul 2>&1 & call config\tcoff.bat
FOR /F "tokens=* delims=" %%x in ('powershell Get-ExecutionPolicy') do set policy=%%x & echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking Powershell execution policy..
if "%policy%"=="Unrestricted " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Current Powershell execution policy is OK.
if NOT "%policy%"=="Unrestricted " powershell Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force; & echo %RESET%[%BRIGHT_GREEN%+%RESET%] Changing Powershell execution policy..
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i smtinpath /s AddedToPath config\settings.ini') do set inpath=%%x & echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking if SMT is in the PATH..
if "%inpath%"=="false " echo %RESET%[%BRIGHT_RED%-%RESET%] SMT is not in the PATH! Adding SMT to it..
if "%inpath%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] SMT is in the PATH.
if "%inpath%"=="false " if "%elevated%"=="true" for /f "tokens=* delims=" %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set OLD_DATA=%%a
if "%inpath%"=="false " if NOT "%elevated%"=="true" for /f "tokens=* delims=" %%a in ('reg query "HKEY_CURRENT_USER\Environment" /v Path') do set OLD_DATA=%%a
if "%OLD_DATA%"=="" set OLD_DATA=Placeholder
if "%inpath%"=="false " if "%OLD_DATA:~-1%"==";" set OLD_DATA=%OLD_DATA:~22%
if "%inpath%"=="false " if NOT "%OLD_DATA:~-1%"==";" set OLD_DATA=%OLD_DATA:~22%;
if "%inpath%"=="false " echo Old PATH EnvVar:>config\old_path.txt & echo.>>config\old_path.txt & echo %OLD_DATA%>>config\old_path.txt
if "%inpath%"=="false " if "%elevated%"=="true" reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /d "%OLD_DATA%C:\Program Files\SMT;" /f >nul
if "%inpath%"=="false " if NOT "%elevated%"=="true" reg add "HKEY_CURRENT_USER\Environment" /v Path /d "%OLD_DATA%C:\Program Files\SMT;" /f >nul
if "%inpath%"=="false " call ini.bat /i smtinpath /s AddedToPath /v true config\settings.ini >nul & set "inpath=true "
echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for internet..
ping -n 2 -w 700 1.1.1.1 | find "TTL=" >nul
if "%ERRORLEVEL%"=="1" (set "internet=nc" & echo %RESET%[%BRIGHT_RED%-%RESET%] You are not connected to the internet.) else (set "internet=c" & echo %RESET%[%BRIGHT_GREEN%+%RESET%] You are connected to the internet.)
if "%internet%"=="c" FOR /F "tokens=* delims=" %%x in ('call ini.bat /i usagepingsent /s Telemetry config\settings.ini') do set "sent=%%x" & echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking if a usage ping has been sent..
if "%internet%"=="c" (
	if /i NOT "%sent%"=="true" echo %RESET%[%BRIGHT_RED%-%RESET%] Usage ping has not been sent, sending now.. & curl -s "https://countapi.mileshilliard.com/api/v1/hit/59422026" >nul 2>&1 & call ini.bat /i usagepingsent /s Telemetry /v true config\settings.ini >nul 
	if /i "%sent%"=="true" echo %RESET%[%BRIGHT_GREEN%+%RESET%] Usage ping has already been sent.
	echo [%BRIGHT_YELLOW%~%RESET%] Fetching usage ping count.. 
	for /f "tokens=* delims=" %%a in ('powershell -Command "$ProgressPreference = 'SilentlyContinue'; (irm https://countapi.mileshilliard.com/api/v1/get/59422026).value"') do (set "pings=%%a" && echo [%BRIGHT_GREEN%+%RESET%] Total usage pings: %%a)
    echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for updates..
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/SchooiCodes/smt/main/Files/config/version -OutFile %TEMP%\version"
    for /f "tokens=* delims=" %%a in (%TEMP%\version) do (
		set "latest_upd=%%a"
        for /f "tokens=* delims=" %%b in (config\version) do (
			set "current_upd=%%b"
            if NOT "%%a"=="%%b" (
                echo %RESET%[%BRIGHT_GREEN%+%RESET%] %%a update available! 
				setlocal enabledelayedexpansion
                choice /c YN /t 30 /D Y /N /M "[%BRIGHT_YELLOW%?%RESET%] Would you like to install it now? [Y/N] "
                if "!ERRORLEVEL!"=="1" (
                    if not exist "%TEMP%\smt" md "%TEMP%\smt"
                    copy /y NUL "%TEMP%\SMT\SkipMSGBox" >nul
                    start /WAIT /MIN "" add_exclusion.bat
                    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/SchooiCodes/smt/raw/main/Schooi`'s%%20Multitool%%20Setup.exe -OutFile %TEMP%\SMT\SMTSetup.exe"
                    "%TEMP%\SMT\SMTSetup.exe" /S
                    rd /s /q "%TEMP%\SMT" >nul
                    if /i "%sent%"=="true" (
                        echo [%BRIGHT_YELLOW%~%RESET%] Ensuring a usage ping doesn't get sent again.. ^(it has already been sent^)
                        call ini.bat /i usagepingsent /s Telemetry /v true config\settings.ini >nul
                    )
                    if /i "%inpath%"=="true " (
                        echo [%BRIGHT_YELLOW%~%RESET%] Ensuring SMT doesn't get re-added to PATH.. ^(it has already been added^)
						call ini.bat /i smtinpath /s AddedToPath /v true config\settings.ini >nul
					)
                    echo [%BRIGHT_GREEN%+%RESET%] SMT was updated, if the script doesn't automatically restart, start it again to continue.
                    timeout /t 5 /NOBREAK >nul
                    exit
                ) else (
                    echo [%BRIGHT_RED%-%RESET%] Update skipped. Continuing...
                )
                endlocal
            )
            if "%%a"=="%%b" echo %RESET%[%BRIGHT_GREEN%+%RESET%] SMT is up to date.
        )
    )
)
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i resizing /s TerminalResizing config\settings.ini') do echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for automatic window resizing.. & set resizing=%%x
if "%resizing%"=="true" (echo %RESET%[%BRIGHT_GREEN%+%RESET%] Automatic window resizing enabled.) else (echo %RESET%[%BRIGHT_RED%-%RESET%] Automatic window resizing disabled.)
timeout /t 3 /NOBREAK >nul
REM set old_dir=%~dp0\Files
set scriptpath=%cd%
goto rpoint

REM :rpoint
REM REM Anti-Piracy
REM if "%CD:~0,3%"=="C:\" if exist "C:\Program Files\SMT\needed_file.schm" goto rpoint
REM if exist "%CD:~0,2%\needed_file.schm" goto rpoint
REM if exist "setup.bat" goto setup
REM goto pirated

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
goto rpoint

:compatibility
if "%resizing%"=="true" mode con cols=85 lines=19
title [SMT ^| %version%] Compatibility Issue
cls
call logo.bat
echo.
echo You are currently using an unsupported version of Windows! Most tools may not work. 
echo Despite this, efforts have been made to add compatibility for older Windows versions.
echo SMT still does not work perfectly on machines running Windows 8 or below.
echo For complete functionality, consider switching to Windows 10 or later.
pause
goto start

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
if %WINDOWSVER% LEQ 6 goto compatibility

:start
if "%resizing%"=="true" mode con cols=80 lines=24
REM FOR /F "tokens=* delims=" %%x in (config\color.ini) DO color %%x
title SMT ^| %version%
cls
call logo.bat
chcp 65001 >nul
if %WINDOWSVER% GEQ 10 echo %CYAN%┌────────────────────┬──────┬──────────────────┐%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% Schooi's Multitool %CYAN%│%RESET% %version% %CYAN%│%RESET% Made by %GRADIENT_DISCORD% %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%└────────────────────┴──────┴──────────────────┘%RESET%
echo Hello, %BRIGHT_BLUE%%username%%RESET%. What would you like to do?
echo 1. Go to the tools
echo 2. Go to the advanced tools
REM echo 3. Edit this script
REM echo 4. Restart this script (to apply any changes)
echo 3. View info about this script
echo 4. View credits
echo 5. Send feedback
echo.
set /p choice=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%choice%"=="1" goto Tools
if /i "%choice%"=="2" goto AdvancedTools
if /i "%choice%"=="3" goto info
if /i "%choice%"=="4" goto credits
if /i "%choice%"=="5" start https://forms.gle/kFFZmknQRkGaZA2y5 & goto start
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
if /i "%choice%"=="tcon" call ini.bat /i coloring /s TerminalTextColoring /v true config\settings.ini >nul & call config\tc.bat
if /i "%choice%"=="tcoff" call ini.bat /i coloring /s TerminalTextColoring /v false config\settings.ini >nul & call config\tcoff.bat
if /i "%choice%"=="mdon" call ini.bat /i resizing /s TerminalResizing /v true config\settings.ini >nul & set "resizing=true" & goto start
if /i "%choice%"=="mdoff" call ini.bat /i resizing /s TerminalResizing /v false config\settings.ini >nul & set resizing=false & mode con cols=120 lines=30 & goto start
if /i "%choice%"=="update" echo. & type ..\updatelogs.txt & echo. & pause & goto start
if /i "%choice%"=="edit" (cd .. & notepad.exe "SchooiMultitool.bat" & cd "Files") & goto start
if /i "%choice%"=="rs" start restart.bat & exit
if /i "%choice%"=="forceupd" echo forced>config\version & start restart.bat & exit
if NOT "%choice%"=="" %choice%
if %ERRORLEVEL% EQU 0 pause >nul
goto start

:tools
if "%resizing%"=="true" mode con cols=80 lines=36
cls
call logo.bat
title [SMT ^| %version%] Tools
echo.
echo Choose a tool:
call :esgbo
echo 1. Password Generator %findstring%
echo 2. Right Click Menu Changer %findstring%
echo 3. Command-Line Game %findstring%
echo 4. Scan Computer for Errors %findstring%
echo 5. Create A System Restore Point %findstring%
echo 6. URL Shortener %findstring%
echo 7. View this system's info %findstring%
echo 8. Enable/Disable Hibernation %findstring%
echo 9. Folder Organizer %findstring%
echo 10. ASCII(/ANSI) Art Generator %findstring%
echo 11. ASCII(/ANSI) Art Gradient Generator %findstring%
echo 12. Credentials Storer %findstring%
echo 13. School Utilities %findstring%
echo.
set /p ch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%ch%"=="B" cls & goto start
if /i "%ch%"=="E" goto end
if /i "%ch%"=="C" set findstring=
if "%ch%"=="/" set /p "findstring=Enter search term: "
if "%ch%"=="/" set findstring=^| find /I "%findstring%"
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
if "%ch%"=="13" start sut.bat
if "%ch%"=="cd" echo %cd% & pause >nul
set "%ch%"="nul"
cls
goto Tools

:advancedtools
if "%resizing%"=="true" mode con cols=80 lines=52
title [SMT ^| %version%] Advanced Tools
cls
call logo.bat
echo.
echo Choose a tool:
call :esgbo
echo 1. Apps %findstring%
echo 2. Danger Zone %findstring%
echo 3. IP Tools %findstring%
echo 4. Performance %findstring%
echo 5. Fixes and Crackers %findstring%
echo 6. .zip Password Cracker %findstring%
echo 7. Text To Speech %findstring%
echo 8. SMB Bruteforcer %findstring%
echo 9. User Manager %findstring%
echo 10. Schnuker %findstring%
echo 11. Driver Backupper %findstring%
echo 12. Batch File Creator %findstring%
echo 13. Backup the Registry %findstring%
echo 14. Import Registry Backups %findstring%
echo 15. rockyou.txt Downloader %findstring%
echo 16. CLI Task Manager %findstring%
echo 17. Wi-Fi Password Shower %findstring%
echo 18. Network Speedtest %findstring%
echo 19. Website Blocker %findstring%
echo 20. NS Lookupper %findstring%
echo 21. Internet Route Tracer %findstring%
echo 22. Directory File Line Counter %findstring%
echo 23. Google Extension Manifest V2 Extender %findstring%
echo 24. Windows Password Cracker (using WSL) %findstring%
echo 25. Bootable USB Creator (using Ventoy) %findstring%
echo 26. Any App (that exists on winget) Installer %findstring%
echo 27. App Installer Generator %findstring%
echo 28. Minecraft Server Creator %findstring%
echo ?. ??? %findstring%
echo.
set /p advch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%advch%"=="B" set findstring= & cls & goto start
if /i "%advch%"=="E" goto end
if /i "%advch%"=="C" set findstring=
if "%advch%"=="/" set /p "findstring=Enter search term: "
if "%advch%"=="/" set findstring=^| find /I "%findstring%"
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
if "%advch%"=="22" start dflc.bat
if "%advch%"=="23" start emv2ae.bat
if "%advch%"=="24" start pc.bat
if "%advch%"=="25" start busbc.bat
if "%advch%"=="26" start aap.bat
if "%advch%"=="27" start aig.bat
if "%advch%"=="28" start mcs.bat
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
if "%resizing%"=="true" mode con cols=80 lines=64
cls
call logo.bat
echo.
echo Apps
echo ====
echo Choose an app:
call :sgbo
echo 1. SuperF4 %findstring%
echo 2. Geek Uninstaller %findstring%
echo 3. Command Prompt %findstring%
echo 4. Powershell %findstring%
echo 5. Powershell 7 %findstring%
echo 6. Powershell (Installer for devices that don't have it) %findstring%
echo 7. Fastfetch %findstring%
echo 8. Git %findstring%
echo 9. Winget %findstring%
echo 10. Chris Titus Tool %findstring%
echo 11. Wintoys %findstring%
echo 12. Windows PC Manager %findstring%
echo 13. f.lux %findstring%
echo 14. Chrome %findstring%
echo 15. Spotify (No Ads) %findstring%
echo 16. Firefox %findstring%
echo 17. 7zip %findstring%
echo 18. Telegram %findstring%
echo 19. Malwarebytes %findstring%
echo 20. Notepad++ %findstring%
echo 21. ShareX %findstring%
echo 22. qBittorrent %findstring%
echo 23. Paint.NET %findstring%
echo 24. Everything %findstring%
echo 25. Github Desktop %findstring%
echo 26. Ultimate Windows Tweaker %findstring%
echo 27. Recuva %findstring%
echo 28. Process Hacker %findstring%
echo 29. Winaero Tweaker %findstring%
echo 30. Discord %findstring%
echo 31. Vencord %findstring%
echo 32. IrfanView %findstring%
echo 33. Playit.gg %findstring%
echo 34. Prism Launcher %findstring%
echo 35. SKLauncher %findstring%
echo 36. Blip %findstring%
echo 37. CapCut Pro (free, guide included) %findstring%
echo 38. RustDesk %findstring%
echo 39. AnyDesk %findstring%
echo 40. Win10 Widgets + Rainmeter 4.0 %findstring%
echo 41. Rainmeter %findstring%
echo.
set /p appch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%appch%"=="B" cls & goto AdvancedTools
if /i "%appch%"=="C" set findstring=
if "%appch%"=="/" set /p "findstring=Enter search term: "
if "%appch%"=="/" set findstring=^| find /I "%findstring%"
if "%appch%"=="1" start Apps\SuperF4.bat
if "%appch%"=="2" start Apps\geek.bat
if "%appch%"=="3" start cmd & cd %olddir%
if "%appch%"=="4" start Apps\powershell & cd %olddir%
if "%appch%"=="5" start Apps\ps7.bat
if "%appch%"=="6" start Apps\pswin7.bat
if "%appch%"=="7" start Apps\fastfetch.bat
if "%appch%"=="8" start Apps\git.bat
if "%appch%"=="9" start Apps\wg.bat
if "%appch%"=="10" start Apps\ctt.bat
if "%appch%"=="11" start Apps\wintoys.bat
if "%appch%"=="12" start Apps\pcm.bat
if "%appch%"=="13" start Apps\flux.bat
if "%appch%"=="14" start Apps\chrome.bat
if "%appch%"=="15" start Apps\bts.bat
if "%appch%"=="16" start Apps\firefox.bat
if "%appch%"=="17" start Apps\7z.bat
if "%appch%"=="18" start Apps\telegram.bat
if "%appch%"=="19" start Apps\mbam.bat
if "%appch%"=="20" start Apps\npp.bat
if "%appch%"=="21" start Apps\sharex.bat
if "%appch%"=="22" start Apps\qbt.bat
if "%appch%"=="23" start Apps\pdn.bat
if "%appch%"=="24" start Apps\evt.bat
if "%appch%"=="25" start Apps\gitd.bat
if "%appch%"=="26" start Apps\uwt.bat
if "%appch%"=="27" start Apps\rcv.bat
if "%appch%"=="28" start Apps\pch.bat
if "%appch%"=="29" start Apps\wat.bat
if "%appch%"=="30" start Apps\dc.bat
if "%appch%"=="31" start Apps\vc.bat
if "%appch%"=="32" start Apps\ifv.bat
if "%appch%"=="33" start Apps\plt.bat
if "%appch%"=="34" start Apps\psm.bat
if "%appch%"=="35" start Apps\skl.bat
if "%appch%"=="36" start Apps\blip.bat
if "%appch%"=="37" start Apps\cc.bat
if "%appch%"=="38" start Apps\rdk.bat
if "%appch%"=="39" start Apps\adk.bat
if "%appch%"=="40" start Apps\w10wr4.bat
if "%appch%"=="41" start Apps\rmt.bat
goto apps

:danger
if "%resizing%"=="true" mode con cols=80 lines=30
cls
call logo.bat
echo.
echo Danger Zone
echo ===========
echo Choose a tool:
call :gbo
echo 1. Windows Destroyer
echo 2. Info Stealer (OLD)
echo 3. Info Stealer Generator (NEW)
echo 4. Disk Space Filler
echo 5. Time Freezer
echo 6. UAC Disabler
echo 7. utilman Trick Applier
echo 8. Windows 11 Tweaker
echo.
set /p dangch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%dangch%"=="B" cls & goto AdvancedTools
if "%dangch%"=="1" start WDDL.bat
if "%dangch%"=="2" start InfoFinder.bat
if "%dangch%"=="3" start isg.bat
if "%dangch%"=="4" start dsf.bat
if "%dangch%"=="5" start tf.bat
if "%dangch%"=="6" start uacd.bat
if "%dangch%"=="7" start uta.bat
if "%dangch%"=="8" start w11.bat
goto danger

:IPTools
if "%resizing%"=="true" mode con cols=80 lines=25
cls
call logo.bat
echo.
echo IP Tools
echo ======
echo Choose a tool:
call :gbo
echo 1. IP Logger
echo 2. IP Geolocator
echo 3. IP Pinger
echo.
set /p ipch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%ipch%"=="B" cls & goto AdvancedTools
if "%ipch%"=="1" start IPLog.bat
if "%ipch%"=="2" start IPGeolocatorDL.bat
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
call :gbo
echo 1. Windows Performance Options
echo 2. Chris Titus Tool
echo 3. Ultimate Performance Power Plan Enabler
echo.
set /p perfch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%perfch%"=="B" cls & goto AdvancedTools
if "%perfch%"=="1" start %windir%\system32\systempropertiesperformance.exe
if "%perfch%"=="2" start apps\ctt.bat
if "%perfch%"=="3" start UPPPE.bat
goto Performance

:fac
if "%resizing%"=="true" mode con cols=80 lines=27
cls
call logo.bat
echo.
echo Fixes ^& Crackers
echo ================
echo Choose a tool:
call :gbo
echo 1. Malwarebytes Premium Resetter
echo 2. "Some Settings Are Managed By Your Organization" Fixer
echo 3. Windows Activator
echo 4. Group Policy Editor Enabler
echo 5. FGRDown (FitGirl Repacks Downloader / Game Piracy Tool)
echo.
set /p facch=%BRIGHT_GREEN%%username%@smt%RESET%:%BRIGHT_BLUE%~%BRIGHT_WHITE%$ 
if /i "%facch%"=="B" cls & goto AdvancedTools
if "%facch%"=="1" start Malwarebytes-Premium-Reset.bat
if "%facch%"=="2" start SSAMBYO.bat
if "%facch%"=="3" start WA.bat
if "%facch%"=="4" start GPEE.bat
if "%facch%"=="5" start fgrdown.bat
goto fac

:info
if not "%calced%"=="1" call :calctools
if "%resizing%"=="true" mode con cols=120 lines=%infomode%
title [SMT ^| %version%] Info
cls
call logo.bat
echo.
REM echo Development started %GOLD%May 2024%RESET%
if "%win_activated%"=="true" echo OS version: %GOLD%%PRODUCTNAME%%RESET% (%BRIGHT_GREEN2%ACTIVATED%RESET%)
if "%win_activated%"=="false" echo OS version: %GOLD%%PRODUCTNAME%%RESET% (%BRIGHT_RED%NOT ACTIVATED%RESET%)
if /i "%accounttype%"=="Domain Account" echo OS username ^& hostname: %GOLD%%username%%RESET% @ %GOLD%%computername%%RESET% (%BRIGHT_CYAN%DOMAIN ACCOUNT%RESET%)
if /i "%accounttype%"=="Local Account" echo OS username ^& hostname: %GOLD%%username%%RESET% @ %GOLD%%computername%%RESET% (%BRIGHT_GREEN2%LOCAL ACCOUNT%RESET%)
if /i "%accounttype%"=="Microsoft Account" echo OS username ^& hostname: %GOLD%%username%%RESET% @ %GOLD%%computername%%RESET% (%BRIGHT_RED%MICROSOFT ACCOUNT%RESET%)
if "%admin_needed%"=="true" echo Schooi's Multitool install location: %GOLD%%~dp0%RESET% (%BRIGHT_CYAN%ADMIN OWNED FOLDER%RESET%)
if "%admin_needed%"=="false" echo Schooi's Multitool install location: %GOLD%%~dp0%RESET% (%BRIGHT_CYAN%USER OWNED FOLDER%RESET%)
echo Schooi's Multitool version: %GOLD%%vnum%%RESET%
if "%internet%"=="c" echo Current update ID: %GOLD%%current_upd%%RESET%
if "%internet%"=="c" if /i "%current_upd%"=="%latest_upd%" echo Latest update ID: %GOLD%%latest_upd%%RESET% (%BRIGHT_GREEN2%UP TO DATE%RESET%)
if "%internet%"=="c" if /i NOT "%current_upd%"=="%latest_upd%" echo Latest update ID: %GOLD%%latest_upd%%RESET% (%BRIGHT_RED%UPDATE NEEDED%RESET%)
echo Current toolcount: %GOLD%%toolCount%%RESET%
if /i NOT "%pings%"=="" echo Total usage pings sent: %BRIGHT_GREEN2%%pings%%RESET%
if NOT "%1"=="" echo Current command line flags: %GOLD%%1%RESET%
echo License: %GOLD%MIT%RESET%
REM echo It is currently %BRIGHT_RED%%date%%RESET%. Still open source! :D
REM echo Don't make changes and say this script is your own!
REM echo Also credit me if you use this for any social media!
REM echo I had a lot of fun making this! (Yes, all %GOLD%%toolCount%%RESET% batch tools)
REM echo Check out the %CYAN%credits%RESET% or type "%CYAN%sc%RESET%" for secret commands on the main menu! :)
REM echo Fun Fact: Almost all the tools are made by me! 
echo.
echo Update logs for the current update ID:%BRIGHT_GREEN2%
type ..\updatelogs.txt
echo.%RESET%
echo Check out the %BRIGHT_CYAN%credits%RESET%, and type "%BRIGHT_CYAN%sc%RESET%" on the main menu for %BRIGHT_CYAN%secret commands%RESET%! :)
echo https://github.com/%GRADIENT_GITHUB%/smt
echo https://youtube.com/@%GRADIENT_YOUTUBE%
echo https://discord.com/users/749226175687295028 (%GRADIENT_DISCORD%)
echo (c) %GRADIENT_SCHOOI% 2026
pause >nul
goto start

:calctools
set calced=1
chcp 437 >nul
for /f "tokens=* delims=" %%a in ('powershell -Command "(Get-Content ..\updatelogs.txt | Measure-Object -Line).Lines"') do set "updatelines=%%a"
for /f "tokens=* delims=" %%a in ('powershell -NoProfile -Command "$sid=(whoami /user | Select-String 'S-1-\d+(-\d+)+' -AllMatches).Matches.Value; if($sid -match '^S-1-12-1-'){'Microsoft Account'}elseif((Get-CimInstance Win32_UserAccount | Where-Object {$_.Name -eq $env:USERNAME}).LocalAccount){'Local Account'}else{'Domain Account'}"') do set "accounttype=%%a"
set /a infomode=32+%updatelines%
chcp 65001 >nul
setlocal enabledelayedexpansion
dir /s *.bat | findstr "File(s)">"%TEMP%\temp.txt"
set lastLine=
set toolCount=
for /f "tokens=* delims=" %%a in ('type "%TEMP%\temp.txt"') do set lastLine=%%a
for /f "tokens=1 delims= " %%b in ("!lastLine!") do set toolCount=%%b
del "%TEMP%\temp.txt"
set /a toolcount=%toolCount%-1
echo %toolcount%>>"%TEMP%\toolnum.txt"
endlocal
FOR /F "tokens=* delims=" %%x in ('type "%TEMP%\toolnum.txt"') DO set toolcount=%%x
del "%TEMP%\toolnum.txt"
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
cls
call logo.bat
color %color%
echo.
echo Current Color: %color%
echo Would you like to change to the %WHITE%old%RESET% color, the %BRIGHT_WHITE%new%RESET% color or go back? (O/N/GB)
echo You can also choose a custom color (check color /? in cmd), just leave the choice blank.
set /p cl=^> 
REM break>config\color.ini
if /i "%cl%"=="O" (
	color 07
	call ini.bat /i hex /s TerminalColor /v 07 config\settings.ini >nul 2>&1
	call ini.bat /i coloring /s TerminalTextColoring /v true config\settings.ini >nul 2>&1
	call config\tc.bat
	REM if exist config\ae.ini (
		REM set "RESET=[0m"
		REM )
	set color=07
	goto start
	)
if /i "%cl%"=="N" (
	color 0f
	call ini.bat /i hex /s TerminalColor /v 0f config\settings.ini >nul 2>&1
	call ini.bat /i coloring /s TerminalTextColoring /v true config\settings.ini >nul 2>&1
	call config\tc.bat
	REM if exist config\ae.ini (
		REM set "RESET=[97m"
		REM )
	set color=0f
	goto start
	)
if /i "%cl%"=="GB" goto start
set /p cc=Custom Color: 
call ini.bat /i hex /s TerminalColor /v %cc% config\settings.ini >nul 2>&1
color %cc%
call ini.bat /i coloring /s TerminalTextColoring /v false config\settings.ini >nul 2>&1
call config\tcoff.bat
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
REM echo %Bright_CYAN%credits%RESET% - shows credits for tools I did not make
echo %Bright_CYAN%rs%RESET% - restarts Schooi's Multitool
echo %Bright_CYAN%edit%RESET% - opens SchooiMultitool.bat in Notepad
echo %Bright_CYAN%forceupd%RESET% - forces a software update and restarts
pause >nul
goto start

:credits
if "%resizing%"=="true" mode con cols=117 lines=32
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
echo %CYAN%INI File Reader (used for settings)%RESET% - %GREEN%rojo on StackOverflow %YELLOW%(%BRIGHT_WHITE%https://bit.ly/3WAxCXz%YELLOW%)%RESET%
echo %CYAN%Any App (that exists on winget) Installer%RESET% - %GREEN%@curlyhair. on Discord %YELLOW%(%BRIGHT_WHITE%https://discordapp.com/users/1063158162036883476%YELLOW%)%RESET%
echo.
echo AI Generated:
echo %CYAN%Folder Organizer%RESET%
echo %CYAN%Clipboard Manager%RESET%
echo %CYAN%Screenshot Tool%RESET%
echo %CYAN%File Integrity Checker%RESET%
pause >nul
goto start

:egbo
if %WINDOWSVER% GEQ 10 echo %CYAN%┌───┬─────────┐%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% B %CYAN%│%RESET% Go Back %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% E %CYAN%│%RESET% Exit    %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%└───┴─────────┘%RESET%
if NOT %WINDOWSVER% GEQ 10 echo B. Go Back
if NOT %WINDOWSVER% GEQ 10 echo E. Exit
goto :EOF

:esgbo
if %WINDOWSVER% GEQ 10 echo %CYAN%┌───┬─────────┐%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% / %CYAN%│%RESET% Search  %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 if NOT "%findstring%"=="" echo %CYAN%│%RESET% C %CYAN%│%RESET% Clear   %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% B %CYAN%│%RESET% Go Back %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% E %CYAN%│%RESET% Exit    %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%└───┴─────────┘%RESET%
if NOT %WINDOWSVER% GEQ 10 echo /. Search
if NOT %WINDOWSVER% GEQ 10 echo B. Go Back
if NOT %WINDOWSVER% GEQ 10 echo E. Exit
goto :EOF

:sgbo
if %WINDOWSVER% GEQ 10 echo %CYAN%┌───┬─────────┐%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% / %CYAN%│%RESET% Search  %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 if NOT "%findstring%"=="" echo %CYAN%│%RESET% C %CYAN%│%RESET% Clear   %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% B %CYAN%│%RESET% Go Back %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%└───┴─────────┘%RESET%
if NOT %WINDOWSVER% GEQ 10 echo B. Go Back
goto :EOF

:gbo
if %WINDOWSVER% GEQ 10 echo %CYAN%┌───┬─────────┐%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%│%RESET% B %CYAN%│%RESET% Go Back %CYAN%│%RESET%
if %WINDOWSVER% GEQ 10 echo %CYAN%└───┴─────────┘%RESET%
if NOT %WINDOWSVER% GEQ 10 echo B. Go Back
goto :EOF

REM :elevate
REM goto :EOF

:end
exit

:help
echo.
echo  Schooi's Multitool is a multitool created to compile many utilities that can be used by advanced Windows users.
echo.
echo  Arguments:
echo.
echo  -d, /d, --debug, /debug           Enters debug mode
echo.
echo  -h, /h, --help, /help             Prints this manual
echo.
echo  -rp, /rp, --restore-point,        Creates a system restore point
echo  /restore-point            
echo.
echo  -32, /32, --system32,             Adds SMT to the path (old, superseeded by automatic path addition on first boot)
echo  /system32
echo.
echo  -pf, /pf, --program-files,        Adds SMT to program files and creates a shortcut on the desktop (old, use exe installer instead)
echo  /program-files
echo.
echo  -na, /na, --noadmin, /noadmin     Runs SMT without admin if it is installed in an admin folder (e.g. Program Files)
echo.
echo  Disclaimers:
echo.
echo  - There are secret commands you can access by typing "sc" in the main menu.
echo  - If any app installers or tools don't work, please contact me on github: https://github.com/SchooiCodes/smt/issues
echo.