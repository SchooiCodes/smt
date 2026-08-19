@echo off
title Clipboard Manager
setlocal enabledelayedexpansion

:menu
cls
if exist logo.bat call logo.bat & echo.
echo Clipboard Manager
echo =================
echo 1. Save Clipboard
echo 2. View Clipboard History
echo 3. Exit
set /p choice="Choose an option: "

if "%choice%"=="1" goto save
if "%choice%"=="2" goto view
if "%choice%"=="3" exit
goto menu

:save
powershell -NoProfile -Command "try { $content = Get-Clipboard -Raw -ErrorAction Stop } catch { $content = $null }; if ([string]::IsNullOrWhiteSpace($content)) { Write-Host 'Clipboard is empty or contains non-text data.'; exit }; $count = 1; if (Test-Path 'clipboard_history.txt') { $count = ([regex]::Matches((Get-Content 'clipboard_history.txt' -Raw -ErrorAction SilentlyContinue), '(?m)^--- Entry \d+').Count) + 1 }; $entry = \"--- Entry $count ($(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')) ---`r`n$content`r`n\"; Add-Content -Path 'clipboard_history.txt' -Value $entry"
echo Clipboard saved!
pause
goto menu

:view
cls
if exist clipboard_history.txt (
    type clipboard_history.txt
) else (
    echo No clipboard history found.
)
pause
goto menu