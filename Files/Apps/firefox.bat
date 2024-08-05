@echo off
cd /d %~dp0
title Firefox Installer
call logo.bat
echo.
echo Firefox Installer
echo ==================
curl --help 1>nul
if NOT %ERRORLEVEL% EQU 0 call :curl
echo Downloading...
curl -o FirefoxInstaller.exe "https://schooicodes.github.io/file_hosting/FirefoxInstaller.exe"
echo Installing...
FirefoxInstaller.exe
if %ERRORLEVEL% EQU 0 echo Success! Cleaning up... & del FirefoxInstaller.exe
if NOT %ERRORLEVEL% EQU 0 echo Error: %ERRORLEVEL%
pause >nul
exit

:curl
goto elevate
bitsadmin /transfer curlDownloadJob /download /priority normal /wait https://curl.se/windows/dl-7.79.1_2/curl-7.79.1_2-win64-mingw.zip %USERPROFILE%\Downloads\curl.zip
powershell -Command "Expand-Archive -Path %USERPROFILE%\Downloads\curl.zip -DestinationPath %USERPROFILE%\Downloads\curl"
cd %USERPROFILE%\Downloads\curl
move curl.exe C:\Windows\System32\
del %USERPROFILE%\Downloads\curl.zip
rd /S /Q %USERPROFILE%\Downloads\curl
PowerShell -Command "Start-Process '%0'
exit /b 0

:elevate
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)
goto curl