@echo off

echo This script will import the registry backups.
echo Make sure you've backed up your important data and system before proceeding.
echo Press any key to continue, or Ctrl+C to exit.
pause >nul

:1
echo Where are the backups located? (Full path required, eg C:\Users\user\Desktop)
set /p loc=^> 
cd "%loc%"
if ERRORLEVEL 1  echo Invalid location! & goto 1

echo Importing registry backups...

reg import HKCR_backup.reg
reg import HKCU_backup.reg
reg import HKLM_backup.reg
reg import HKU_backup.reg
reg import HKCC_backup.reg

echo Registry backups imported successfully.

pause
