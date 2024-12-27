@echo off
setlocal enabledelayedexpansion
title File Integrity Checker

:menu
cls
if exist logo.bat call logo.bat & echo.
echo File Integrity Checker
echo ======================
echo 1. Generate File Hash
echo 2. Verify File Hash
echo 3. Exit
set /p choice="Choose an option: "

if "%choice%"=="1" goto generate
if "%choice%"=="2" goto verify
if "%choice%"=="3" exit
goto menu

:generate
set /p filepath="Enter the file path: "
set /p alg="Enter the hash algorithm (MD5, SHA1, SHA256): "
certutil -hashfile "%filepath%" %alg%
pause
goto menu

:verify
set /p filepath="Enter the file path: "
set /p alg="Enter the hash algorithm (MD5, SHA1, SHA256): "
set /p expectedhash="Enter the expected hash: "
for /f "tokens=*" %%a in ('certutil -hashfile "%filepath%" %alg% ^| findstr /i /v "hash"') do set filehash=%%a
if "%filehash%"=="%expectedhash%" (
    echo Hash matches!
) else (
    echo Hash does not match!
)
pause
goto menu
