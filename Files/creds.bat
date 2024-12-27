@echo off

:start
cls
title Account Password Logger
if exist logo.bat call logo.bat & echo.
echo Account Picker
echo =================
echo 1. Add an account
echo 2. View all saved accounts
echo 3. Change an account's credentials
set /p choice=^> 
if %choice%==1 goto add
if %choice%==2 if exist accs.txt goto view
if %choice%==2 if not exist accs.txt echo You haven't saved any passwords yet. & pause >nul
if %choice%==3 goto mod
goto start

:add
cls
if exist logo.bat call logo.bat & echo.
echo DISCLAIMER: Your credentials will not be encrypted, do not store them in plain sight.
echo.
echo Please enter the type of the account (Google, YouTube, GitHub etc.)
set /p type=^> 
echo Please enter a username for the account.
set /p user=^> 
echo Please enter a password for "%user%" 
set /p pass=^> 
echo Is this correct? ([Y]es/[N]o) ^| Type: %type%, Username: %user%, Password: %pass%
set /p conf[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irmation=^> 
if /i %conf[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irmation%==N cls & echo Please try again. & goto add
if not exist accs.txt echo Type     ^|     Username     ^|     Password>>accs.txt & echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=>>accs.txt
echo %type%     ^|     %user%     ^|     %pass%>>accs.txt
echo Success!
pause
goto start

:view
cls
call logo.bat
echo Saved Accounts:
echo ================
echo.
type accs.txt
echo.
pause
goto start

:mod
cls
if exist logo.bat call logo.bat & echo.
echo Starting notepad..
notepad accs.txt
pause
goto start