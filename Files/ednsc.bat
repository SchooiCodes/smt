@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d "%~dp0"
title Easy DNS Changer
setlocal enabledelayedexpansion
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1 -ExpandProperty Name)"') do set ADAPTER_NAME=%%A
if not defined ADAPTER_NAME (echo Could not detect an active network adapter. & pause & exit /b 1)

:confirm
cls
if exist logo.bat call logo.bat & echo.
echo Detected adapter: %ADAPTER_NAME%
set /p CONFIRM="Is this the correct adapter? (Y/N): "
if /i "%CONFIRM%"=="Y" goto proceed
if /i "%CONFIRM%"=="N" goto pick_manual
echo Please enter Y or N.
goto confirm

:pick_manual
echo.
echo Available adapters:
powershell -NoProfile -Command "Get-NetAdapter | Format-Table -Property Name, Status, InterfaceDescription -AutoSize"
set "ADAPTER_NAME="
set /p ADAPTER_NAME="Enter the exact adapter name to use: "
if not defined ADAPTER_NAME (echo No adapter name entered. Exiting. & pause & exit /b 1)
powershell -NoProfile -Command "if (-not (Get-NetAdapter -Name '%ADAPTER_NAME%' -ErrorAction SilentlyContinue)) { exit 1 }"
if errorlevel 1 (
    echo Adapter "%ADAPTER_NAME%" not found.
    pause
    goto pick_manual
)
echo.
echo You entered: %ADAPTER_NAME%
set /p CONFIRM2="Confirm this is correct? (Y/N): "
if /i "%CONFIRM2%"=="Y" goto proceed
if /i "%CONFIRM2%"=="N" goto pick_manual
echo Please enter Y or N.
goto pick_manual

:proceed
echo.
echo Using adapter: %ADAPTER_NAME%
timeout /t 3 >NUL
set "NEXTDNS=FALSE"

:menu
cls
if exist logo.bat call logo.bat & echo.
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Get-DnsClientServerAddress -InterfaceAlias '%ADAPTER_NAME%' -AddressFamily IPv4).ServerAddresses -join ', '"') do set "CURRENT_DNS=%%A"
if not defined CURRENT_DNS set "CURRENT_DNS=DHCP/Automatic"
echo DNS Changer
echo ===========
echo Adapter: %ADAPTER_NAME%
echo Current DNS: !CURRENT_DNS!
set "CURRENT_DNS="
echo 1. Set DNS to Google
echo 2. Set DNS to Cloudflare
echo 3. Set DNS to Cloudflare Family
echo 4. Set DNS to OpenDNS
echo 5. Set DNS to Quad9
echo 6. Set DNS to AdGuard DNS
echo 7. Set DNS to NextDNS (Recommended)
echo 8. Set Custom DNS
echo 9. Reset DNS to default
echo 10. Exit
echo.
set "choice="
set /p choice=Choose an option: 
if "!choice!" == "1" goto :google
if "!choice!" == "2" goto :cloudflare
if "!choice!" == "3" goto :cloudflarefamily
if "!choice!" == "4" goto :opendns
if "!choice!" == "5" goto :quad9
if "!choice!" == "6" goto :adguard
if "!choice!" == "7" goto :nextdns
if "!choice!" == "8" goto :custom
if "!choice!" == "9" goto :reset
if "!choice!" == "10" exit
echo Invalid option.
pause
goto :menu

:google
set dns1=8.8.8.8
set dns2=8.8.4.4
goto :setdns

:cloudflare
set dns1=1.1.1.1
set dns2=1.0.0.1
goto :setdns

:cloudflarefamily
set dns1=1.1.1.3
set dns2=1.0.0.3
goto :setdns

:opendns
set dns1=208.67.222.222
set dns2=208.67.220.220
goto :setdns

:quad9
set dns1=9.9.9.9
set dns2=149.112.112.112
goto :setdns

:adguard
set dns1=94.140.14.14
set dns2=94.140.15.15
goto :setdns

:nextdns
set "PROFILEID="
echo Don't have one? Go to https://my.nextdns.io
set /p PROFILEID="What is your NextDNS profile ID? > "
if not defined PROFILEID (
    echo No profile ID entered.
    pause
    goto :menu
)
set dns1=45.90.28.0
set dns2=45.90.30.0
set "NEXTDNS=TRUE"
goto :setdns

:custom
cls
if exist logo.bat call logo.bat & echo.
echo Set Custom DNS
echo ==============
set "dns1="
set "dns2="
set /p dns1=Enter primary DNS: 
set /p dns2=Enter secondary DNS: 
if not defined dns1 (echo No primary DNS entered. & pause & goto :menu)
if not defined dns2 (echo No secondary DNS entered. & pause & goto :menu)
goto :setdns

:reset
cls
if exist logo.bat call logo.bat & echo.
echo Resetting DNS to default...
netsh interface ip set dns name="%ADAPTER_NAME%" dhcp
echo DNS settings have been reset to default.
pause
goto :menu

:setdns
cls
if exist logo.bat call logo.bat & echo.
echo Setting DNS to !dns1! and !dns2!...
netsh interface ip set dns name="%ADAPTER_NAME%" static !dns1! primary >nul
netsh interface ip add dns name="%ADAPTER_NAME%" !dns2! index=2 >nul
if "!NEXTDNS!"=="TRUE" (
    echo Setting NextDNS profile ID..
    netsh dns add encryption server=!dns1! dohtemplate=https://dns.nextdns.io/!PROFILEID! autoupgrade=yes udpfallback=no >nul
    netsh dns add encryption server=!dns2! dohtemplate=https://dns.nextdns.io/!PROFILEID! autoupgrade=yes udpfallback=no >nul
)
echo DNS settings have been changed successfully.
set "NEXTDNS=FALSE"
pause
goto :menu