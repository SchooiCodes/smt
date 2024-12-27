@echo off
title Registry Backupper
if exist logo.bat call logo.bat & echo.
echo Registry Backupper
echo ==================
setlocal

echo Where would you like the backups to be saved? (Full path required eg. C:\Users\user\Desktop)
set /p loc=^> 
if not exist "%loc%" mkdir "%loc%"
cd "%loc%"

echo Creating backup of HKEY_CLASSES_ROOT (HKCR)
reg export HKEY_CLASSES_ROOT "HKCR_backup.reg" /y
echo Creating backup of HKEY_CURRENT_USER (HKCU)
reg export HKEY_CURRENT_USER "HKCU_backup.reg" /y
echo Creating backup of HKEY_LOCAL_MACHINE (HKLM)
reg export HKEY_LOCAL_MACHINE "HKLM_backup.reg" /y
echo Creating backup of HKEY_USERS (HKU)
reg export HKEY_USERS "HKU_backup.reg" /y
echo Creating backup of HKEY_CURRENT_CONFIG (HKCC)
reg export HKEY_CURRENT_CONFIG "HKCC_backup.reg" /y

echo Backup completed.
pause >nul
exit

