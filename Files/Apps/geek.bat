@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Geek Uninstaller Installation
if exist logo.bat call logo.bat & echo.
if "%~1"=="choco" goto geek
set "GEEK_DIR=%appdata%\Geek Uninstaller"
if not exist "%GEEK_DIR%" md "%GEEK_DIR%"
where geek.exe
if %ERRORLEVEL% NEQ 0 (echo Installing.. & call :winget) else (echo Already installed..)
echo Starting..
geek.exe
timeout /t 5 >nul
exit /b 0

:winget
winget --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (echo Winget not found. Using irm instead.. & call :irm & goto :EOF)
echo Installing via winget..
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id GeekUninstaller.GeekUninstaller
if %ERRORLEVEL% NEQ 0 (echo Winget install failed! Using irm instead.. & call :irm)
goto :EOF

:irm
powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://geekuninstaller.com/geek.zip -OutFile '%GEEK_DIR%\geek.zip'"
if %ERRORLEVEL% NEQ 0 (echo IRM failed! Using choco instead.. & goto geek)
powershell -NoProfile -Command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path '%GEEK_DIR%\geek.zip' -DestinationPath '%GEEK_DIR%\' -Force"
if %ERRORLEVEL% NEQ 0 (echo Extraction failed! Using choco instead.. & goto geek)
del "%GEEK_DIR%\geek.zip"
call :shortcut "%GEEK_DIR%\geek.exe"
goto :EOF

:shortcut
set "TARGET=%~1"
set "SCRIPT=%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
> "%SCRIPT%" (echo Set oWS = WScript.CreateObject("WScript.Shell"^) & echo sLinkFile = "%USERPROFILE%\Desktop\Geek Uninstaller.lnk" & echo Set oLink = oWS.CreateShortcut(sLinkFile^) & echo oLink.TargetPath = "%TARGET%" & echo oLink.Save)
cscript //nologo "%SCRIPT%"
del "%SCRIPT%"
goto :EOF

:refreshenv
if not exist "..\RefreshEnv.cmd" (powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/chocolatey/choco/raw/refs/heads/master/src/chocolatey.resources/redirects/RefreshEnv.cmd -OutFile ..\RefreshEnv.cmd")
call ..\RefreshEnv.cmd
goto :EOF

:geek
REM Only this path needs admin (chocolatey install)
fltmc >nul 2>&1 || (echo Restarting as admin.. & PowerShell Start -Verb RunAs '%0' %* 2> nul || (>nul pause && exit 1) & exit 0)
where choco >nul 2>&1
if %ERRORLEVEL% NEQ 0 (echo Choco not found. Running installer.. & call getchoco.bat & call :refreshenv)
echo Downloading geek uninstaller..
choco install geekuninstaller -y --force
set "CHOCO_EXE=C:\ProgramData\chocolatey\lib\geekuninstaller\tools\geek.exe"
if not exist "%CHOCO_EXE%" (echo Chocolatey install failed - geek.exe not found. & pause & exit /b 1)
call :shortcut "%CHOCO_EXE%"
echo Starting..
start "" "%CHOCO_EXE%"
timeout /t 5 >nul
exit /b 0