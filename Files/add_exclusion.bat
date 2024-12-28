@echo off
title SMT - Admin required
fltmc >nul 2>&1 || (
	if exist logo.bat call logo.bat & echo.
	echo SMT needs to make changes that require admin! Restarting as admin..
	PowerShell Start -Verb RunAs '%0' 2> nul || (
		>nul pause && exit 1
	)
	exit 0
)
if exist logo.bat call logo.bat & echo.
powershell -Command "Add-MpPreference -ExclusionPath '%TEMP%\SMT\SMTSetup.exe'"
echo Changes made.
exit