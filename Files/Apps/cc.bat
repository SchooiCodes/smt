@echo off 
cd /d "%~dp0" 
if exist logo.bat call logo.bat & echo.  
title CapCut Installer 
echo CapCut Installer 
echo ================== 
winget --version 2>&1 >nul 
if NOT %ERRORLEVEL% EQU 0 goto irm 
echo Installing via winget.. 
winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id ByteDance.CapCut 
if %ERRORLEVEL% NEQ 0 goto irm 
call :show_pro_method
 
 
:irm 
echo Winget not found! Falling back to using irm to download the installer and installing manually..
echo Downloading.. 
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://sf16-web-tos-buz.capcutstatic.com/obj/capcut-web-buz-sg/packages/CapCut_9_1_0_3879_capcutpc_0_creatortool.exe"' -OutFile '%TEMP%\ccinstaller.exe'" 
echo Installing.. 
start /WAIT "" "%TEMP%\ccinstaller.exe" 
echo Done! 
del "%TEMP%\ccinstaller.exe" >nul 
call :show_pro_method

:show_pro_method
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm sfh.gleeze.com/capcut_noicons.png -OutFile '%USERPROFILE%\Desktop\How to get all pro CapCut features.png'" 
echo An image has been placed on your desktop, showing you how to use all Pro features for free.
echo Enjoy your CapCut pro!
echo Press any key to exit..
pause >nul
exit