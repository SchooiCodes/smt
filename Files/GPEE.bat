@echo off 
title Group Policy Editor Enabler
echo This batch file from https://majorgeeks.com will enable Group Policy Editor (gpedit.msc) on Windows.
echo If this method fails, there are other methods to try at https://tinyurl.com/majorgeeksgpedit
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
echo Press any key to start..
pause >nul
cd /d "%~dp0" 

dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 
dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 

for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 
pause
exit