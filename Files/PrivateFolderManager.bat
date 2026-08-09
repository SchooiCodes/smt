:: Improved by Schooi :)
:: Release v1.0: 24/4/2025
:: Latest update: 9/8/2026
:: Also check out SMT! https://github.com/SchooiCodes/smt
@echo off
cd /d "%~dp0"
color 0f
if not exist "%appdata%\PrivateFolderManager" md "%appdata%\PrivateFolderManager"
if exist "%appdata%\PrivateFolderManager\folder_location" for /f "tokens=* delims=" %%a in (%appdata%\PrivateFolderManager\folder_location) do (set folder_location=%%a)
if exist "%appdata%\PrivateFolderManager\password" for /f "tokens=* delims=" %%a in (%appdata%\PrivateFolderManager\password) do (set password=%%a)
if exist "%appdata%\PrivateFolderManager\folder_name" for /f "tokens=* delims=" %%a in (%appdata%\PrivateFolderManager\folder_name) do (set folder_name=%%a)
title Private Folder Manager ^| v1.0
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
if %WINDOWSVER% GEQ 10 (
	set "Black=[30m"
	set "Yellow=[33m"
	set "Bright_Green=[92m"
	set "Bright_Cyan=[96m"
	set "Bright_Red=[91m"
	set "Reset=[97m"
	set "g1=[38;2;135;206;250m"
	set "g2=[38;2;135;206;240m"
	set "g3=[38;2;135;206;230m"
	set "g4=[38;2;135;206;220m"
	set "g5=[38;2;135;206;210m"
	set "g6=[38;2;135;206;200m"
)
call :logo
if EXIST "%folder_location%\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK
if NOT EXIST "%folder_location%\%folder_name%" goto MDLOCKER

:LOCK
echo [%YELLOW%~%RESET%] Locking folder..
echo [%YELLOW%~%RESET%] Hiding the folder by disguising it to look like the Control Panel..
ren "%folder_location%\%folder_name%" "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo [%YELLOW%~%RESET%] Hiding the folder by giving it the "hidden" and "system" file attributes..
attrib +h +s "%folder_location%\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo [%BRIGHT_GREEN%+%RESET%] Folder locked!
echo [%BRIGHT_CYAN%!%RESET%] Run PrivateFolderManager again to unlock it.
goto End

:UNLOCK
set /p "pass=[%YELLOW%?%RESET%] Enter the folder's password: %BLACK%"
if NOT "%pass%"=="%password%" echo %RESET%[%BRIGHT_RED%-%RESET%] Invalid password! & goto UNLOCK
echo %RESET%[%YELLOW%~%RESET%] Showing the folder by removing the "hidden" and "system" file attributes..
attrib -h -s "%folder_location%\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo [%YELLOW%~%RESET%] Showing the folder by reverting the Control Panel disguise..
ren "%folder_location%\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" "%folder_name%"
echo [%BRIGHT_GREEN%+%RESET%] Folder unlocked!
echo [%BRIGHT_CYAN%!%RESET%] Place the files you need to hide in the folder and run PrivateFolderManager again to lock it.
cd "%folder_location%\%folder_name%"
explorer .
cd ..
goto End

:MDLOCKER
set /p folder_location=[%YELLOW%?%RESET%] Please set a location for the folder: 
if "%folder_location:~-1%"=="\" set "folder_location=%folder_location:~0,-1%"
set /p folder_name=[%YELLOW%?%RESET%] Please set a name for the folder: 
set /p password=[%YELLOW%?%RESET%] Please set a password for the folder: %BLACK%
echo %RESET%[%YELLOW%~%RESET%] Saving the folder's location to "%appdata%\PrivateFolderManager\folder_location"..
echo %folder_location%> "%appdata%\PrivateFolderManager\folder_location"
echo %RESET%[%YELLOW%~%RESET%] Saving the folder's name to "%appdata%\PrivateFolderManager\folder_name"..
echo %folder_name%> "%appdata%\PrivateFolderManager\folder_name"
echo [%YELLOW%~%RESET%] Saving the password to "%appdata%\PrivateFolderManager\password"..
echo %password%> "%appdata%\PrivateFolderManager\password"
md "%folder_location%\%folder_name%"
echo [%BRIGHT_CYAN%!%RESET%] Disclaimer: If you ever need to change the name or password of the folder, edit the above files.
REM echo [%BRIGHT_CYAN%!%RESET%] Disclaimer: "%folder_name%" must ALWAYS be in the same folder as PrivateFolderManager!
echo [%BRIGHT_GREEN%+%RESET%] Private folder named "%folder_name%" created in "%folder_location%"!
echo [%BRIGHT_CYAN%!%RESET%] Place the files you need to hide in the folder and run PrivateFolderManager again to lock it.
cd /d "%folder_location%\%folder_name%"
explorer .
goto End

:logo
chcp 65001 >nul
echo %g1% ██████╗ ███████╗███╗   ███╗%RESET% Originally Passlock.bat by CHM Tech
echo %g2% ██╔══██╗██╔════╝████╗ ████║%RESET% (https://bit.ly/chmtechpasslock)
echo %g3% ██████╔╝█████╗  ██╔████╔██║%RESET%
echo %g4% ██╔═══╝ ██╔══╝  ██║╚██╔╝██║%RESET% 
echo %g5% ██║     ██║     ██║ ╚═╝ ██║%RESET% Private Folder Manager
echo %g6% ╚═╝     ╚═╝     ╚═╝     ╚═╝%RESET% by Schooi (@schooi. on Discord, SchooiCodes on Github)
echo.
chcp 437 >nul
goto :EOF

:End
echo [%YELLOW%~%RESET%] Press any key to exit..
pause >nul
exit