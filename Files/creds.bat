@echo off

:start
cls
title Account Password Logger
call logo.bat
echo.
echo Account Picker
echo =================
echo 1. Add an account
echo 2. View all saved accounts
echo 3. Change an account's credentials
set /p choice=^> 
if %choice%==1 goto add
if %choice%==2 goto view
if %choice%==3 goto mod
goto start

:add
cls
call logo.bat
echo.
echo DISCLAIMER: Your credentials will not be encrypted, do not store them in plain sight.
echo.
echo Please enter the type of the account (Google, YouTube, GitHub etc.)
set /p type=^> 
echo Please enter a username for the account.
set /p user=^> 
echo Please enter a password for "%user%" 
set /p pass=^> 
echo Is this correct? ([Y]es/[N]o) ^| Type: %type%, Username: %user%, Password: %pass%
set /p confirmation=^> 
if /i %confirmation%==N cls & echo Please try again. & goto add
echo Type: %type%, Username: %user%, Password: %pass%>>accs.txt
echo Success!
pause
goto start

:view
cls
call logo.bat
echo Saved Accounts:
echo ================
type accs.txt
echo.
pause
goto start

:mod
cls
call logo.bat
echo.
echo Starting notepad..
notepad accs.txt
pause
goto start