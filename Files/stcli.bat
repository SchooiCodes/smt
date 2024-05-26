@echo off
title Speedtest CLI
call logo.bat
echo.
echo   Ookla Speedtest CLI
echo ==========================
if exist ooklacli\speedtest.exe echo Starting.. & goto start
if NOT exist ooklacli\speedtest.exe echo Installing.. & goto install

:start
echo.
cd ooklacli
speedtest.exe

:install
set "olddir=%CD%"
echo Checking for 7zip..
where 7z.exe >nul 2>nul
IF NOT ERRORLEVEL 0 (
    echo 7z.exe not found in path.
    for /f %%a in ('wmic os get osarchitecture ^| find /i "bit"') do set "bits=%%a"
    echo Your architecture: %bits%
	echo Please install 7-zip and then press any key in this window to continue.
	start https://7-zip.org/
    pause >nul
)
cd %~dp0
echo Downloading the zip file..
powershell -Command "Invoke-WebRequest -Uri 'https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip' -OutFile 'ookla-speedtest-1.2.0-win64.zip'"
echo Extracting the zip file..
7z x ookla-speedtest-1.2.0-win64.zip -oooklacli
echo Cleaning up..
del ookla-speedtest-1.2.0-win64.zip
cd ooklacli
cls
call %~dp0logo.bat
echo.
speedtest.exe
pause >nul
cd "%olddir%"
exit
