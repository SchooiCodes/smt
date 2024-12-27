@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d "%~dp0"
if exist logo.bat call logo.bat & echo.
echo Extension Manifest V2 Availability Extender
echo ============================================
echo Google is planning to change the manifest of extensions, in a desperate try to get rid of uBlock and such adblockers.
echo This script will extend the availability up to June 2025.
echo Press any key to start.
pause >nul
echo.
echo Killing Chrome..
start chrome.exe
taskkill /f /im chrome.exe >nul
echo Adding required registry keys and DWORD values..
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v ExtensionManifestV2Availability /t REG_DWORD /d 2 /f >nul
if %ERRORLEVEL% EQU 0 echo Success! Would you like to verify that the policy has been added? {Y/N}
set /p ver=^> 
if /i "%ver%"=="Y" echo To do so, start chrome and type in the URL bar chrome://policy and check if ExtensionManifestV2Availability is added as one and is set to Mandatory.
pause >nul
exit