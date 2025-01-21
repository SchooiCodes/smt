@echo off
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)

:start
cd /d "%~dp0"
title Geek Uninstaller Installation
if exist logo.bat call logo.bat & echo.
if not exist "%appdata%\Geek Uninstaller" md "%appdata%\Geek Uninstaller"
echo Installing..
if NOT exist "%appdata%\Geek Uninstaller\geek.exe" call :irm
echo Starting..
cd %appdata%\Geek Uninstaller
geek.exe
timeout /t 10 >nul
exit

:irm
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://geekuninstaller.com/geek.zip -OutFile '%appdata%\Geek Uninstaller\geek.zip'" 
if NOT %ERRORLEVEL% EQU 0 echo IRM failed! Using choco instead.. & goto geek
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path '%appdata%\Geek Uninstaller\geek.zip' -DestinationPath '%appdata%\Geek Uninstaller\'" 
del "%appdata%\Geek Uninstaller\geek.zip"
if %ERRORLEVEL% EQU 0 call :shortcut "%appdata%\Geek Uninstaller\geek.exe" 
goto :EOF

:shortcut
set TARGET=%1
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Geek Uninstaller.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = %TARGET% >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
goto :EOF

:geek
choco /? 1>nul
if NOT %ERRORLEVEL% EQU 0 goto :choco
if NOT exist C:\ProgramData\chocolatey\lib\geekuninstaller\tools\geek.exe goto geek
echo Downloading geek uninstaller..
choco install geekuninstaller -y
call :shortcut "C:\ProgramData\chocolatey\lib\geekuninstaller\tools\geek.exe"
echo Starting..
cd C:\ProgramData\chocolatey\lib\geekuninstaller\tools\
geek.exe
timeout /t 10 >nul
exit

:choco
echo Installing Chocolatey...
powershell Set-ExecutionPolicy AllSigned
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
echo Please sign out, sign in and re-run this script to install Geek Uninstaller.
timeout /t 10 /NOBREAK >nul
exit /b 0


