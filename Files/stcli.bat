@echo off
cd %~dp0
title Speedtest CLI
if exist logo.bat call logo.bat & echo.
echo   Ookla Speedtest CLI
echo ==========================
if exist ooklacli\speedtest.exe echo Starting.. & goto start
if NOT exist ooklacli\speedtest.exe echo Installing.. & goto install

:start
echo.
cd ooklacli
speedtest.exe
echo Press any key to clean up..
pause >nul
cd %~dp0
rd /s /q ooklacli
exit

:install
echo Checking for 7zip..
where 7z.exe >nul 2>nul
IF "%ERRORLEVEL%" NEQ "0" set szmissing=true
if "%szmissing%"=="true" echo 7z.exe not found in path.
if "%szmissing%"=="true" if exist "%~dp0Apps\7z.bat" start /WAIT "" "%~dp0Apps\7z.bat"
if "%szmissing%"=="true" if not exist "%~dp0Apps\7z.bat"  for /f %%a in ('powershell -command "(Get-CimInstance Win32_OperatingSystem).OSArchitecture"') do set "bits=%%a"
if "%szmissing%"=="true" if not exist "%~dp0Apps\7z.bat"  echo Your architecture: %bits%
if "%szmissing%"=="true" if not exist "%~dp0Apps\7z.bat"  echo Please install 7-zip and then press any key in this window to continue.
if "%szmissing%"=="true" if not exist "%~dp0Apps\7z.bat" start https://7-zip.org/
if "%szmissing%"=="true" if not exist "%~dp0Apps\7z.bat"  pause >nul
if "%szmissing%"=="true" powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm 'https://schooicodes.github.io/file_hosting/7z.exe' -OutFile '7z.exe'"
if "%szmissing%"=="true" powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm 'https://schooicodes.github.io/file_hosting/7z.dll' -OutFile '7z.dll'"
if "%szmissing%"=="true" set local=%~dp0
echo Downloading the zip file..
powershell -Command "$ProgressPreference = 'SilentlyContinue'; irm 'https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip' -OutFile 'ookla-speedtest-1.2.0-win64.zip'"
echo Extracting the zip file..
"%local%7z.exe" x ookla-speedtest-1.2.0-win64.zip -oooklacli
echo Cleaning up..
del ookla-speedtest-1.2.0-win64.zip
if exist "%~dp07z.exe" del "%~dp07z.exe"
if exist "%~dp07z.dll" del "%~dp07z.dll"
cd ooklacli
cls
call "%~dp0logo.bat"
echo.
speedtest.exe
echo.
echo Press any key to clean up and exit..
pause >nul
cd %~dp0
rd /s /q ooklacli
exit
