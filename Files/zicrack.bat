@echo off
title ZIP Cracker ^| v1.0
if exist logo.bat call logo.bat & echo.
echo Schooi's ZIP cracker v1.0
echo ---------------------------
if not exist "C:\Program Files\7-Zip" (
    echo [ERROR] 7-Zip not installed!
    echo [7-ZIP] To download 7-zip, go to https://www.7-zip.org/
    pause
    exit
)

set /p archive="[CONSOLE] Enter Archive: "
if not exist "%archive%" (
    echo [ERROR] Archive not found, please check if the filename is correct!
    pause
    exit
)

set /p wordlist="[CONSOLE] Enter wordlist: "
if not exist "%wordlist%" (
    echo [ERROR] Wordlist not found!
    pause
    exit
)

for /f %%a in (%wordlist%) do (
    set pass=%%a
    call :attempt
)

echo [FAILURE] Password not found in wordlist.
pause
exit

:attempt
"C:\Program Files\7-Zip\7z.exe" x -p%pass% "%archive%" -o"Cracked" -y >NUL
echo Cracking...
echo [ATTEMPT] %pass%
if errorlevel 0 (
    echo [SUCCESS] Password found: %pass%
    pause
    exit
)
exit /b
