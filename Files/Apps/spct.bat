@echo off
net session >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo Restarting as non-admin...
    runas /trustlevel:0x20000 "%~f0"
	exit
)
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title Spicetify Installer 
echo Spicetify Installer 
echo ================== 
echo Checking for Spotify..
if not exist "%appdata%\Spotify" echo Spotify not found, installing.. & if not exist spt.bat (powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/SchooiCodes/smt/refs/heads/main/Files/Apps/spt.bat -OutFile spt.bat") & start /MIN /WAIT spt.bat
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id Spicetify.Spicetify
if NOT ERRORLEVEL 0 echo Winget failed. Installing via irm.. & powershell iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 ^| iex
echo Installing plugins to make Spotify ad-free and useful..
if not exist "%appdata%\spicetify\Extensions" md "%appdata%\spicetify\Extensions"
set /p "market=Would you like to install the Spicetify Marketplace? ([Y]es/[n]o) > "
if /i "%market%"=="y" (
	powershell iwr -useb https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1 ^| iex
)
set /p "adblock=Would you like to block ads? ([Y]es/[n]o) > "
if /i "%adblock%"=="y" (
	echo Getting adblock.js..
	powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/rxri/spicetify-extensions/refs/heads/main/adblock/adblock.js -OutFile '%appdata%\spicetify\Extensions\adblock.js'"
	echo Setting it up..
	"%localappdata%\spicetify\spicetify.exe" config extensions adblock.js
)
set /p "spicy=Would you like to get song lyrics without premium? ([Y]es/[n]o) > "
if /i "%spicy%"=="y" (
	echo Getting beatiful-lyrics.mjs..
	powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/Spikerko/spicy-lyrics/raw/refs/heads/main/builds/spicy-lyrics.mjs -OutFile '%appdata%\spicetify\Extensions\spicy-lyrics.mjs'"
	echo Setting it up..
	"%localappdata%\spicetify\spicetify.exe" config extensions spicy-lyrics.mjs
)
echo Applying changes..
"%localappdata%\spicetify\spicetify.exe" update
"%localappdata%\spicetify\spicetify.exe" backup apply
echo Done.
pause
exit