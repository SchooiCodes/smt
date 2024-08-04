@echo off
title Easy DNS Changer
setlocal enabledelayedexpansion

:menu
cls
call logo.bat
echo.
echo DNS Changer
echo ===========
echo 1. Set DNS to Google
echo 2. Set DNS to Cloudflare
echo 3. Set DNS to OpenDNS
echo 4. Set Custom DNS
echo 5. Reset DNS to default
echo 6. Exit
echo.
set /p choice=Choose an option: 

if !choice! == 1 goto :google
if !choice! == 2 goto :cloudflare
if !choice! == 3 goto :opendns
if !choice! == 4 goto :custom
if !choice! == 5 goto :reset
if !choice! == 6 exit

:google
set dns1=8.8.8.8
set dns2=8.8.4.4
goto :setdns

:cloudflare
set dns1=1.1.1.1
set dns2=1.0.0.1
goto :setdns

:opendns
set dns1=208.67.222.222
set dns2=208.67.220.220
goto :setdns

:custom
cls
echo.
echo Set Custom DNS
echo ==============
set /p dns1=Enter primary DNS: 
set /p dns2=Enter secondary DNS: 
goto :setdns

:reset
cls
echo.
echo Resetting DNS to default...
netsh interface ip set dns "Ethernet" dhcp
netsh interface ip set dns "Wi-Fi" dhcp
echo DNS settings have been reset to default.
pause
goto :menu

:setdns
cls
echo.
echo Setting DNS to !dns1! and !dns2!...
netsh interface ip set dns "Ethernet" static !dns1!
netsh interface ip add dns "Ethernet" !dns2! index=2
netsh interface ip set dns "Wi-Fi" static !dns1!
netsh interface ip add dns "Wi-Fi" !dns2! index=2
echo DNS settings have been changed successfully.
pause
goto :menu
