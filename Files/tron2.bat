@echo off
cd /d "%~dp0"
title Tron - SMT
if exist logo.bat call logo.bat & echo.
echo Setting up Tron..
cd "%USERPROFILE%\Downloads\Tron v12.0.8 (2025-01-09)"
move tron.bat "%USERPROFILE%\Desktop\" >nul
if exist "%USERPROFILE%\Desktop\resources" echo "%USERPROFILE%\Desktop\resources" already exists. Renaming to resources_old.. & ren "%USERPROFILE%\Desktop\resources" resources_old >nul
move resources "%USERPROFILE%\Desktop\" >nul
copy /y "%~dp0runtron.bat" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" >nul
echo Restarting..
shutdown -r -t 0
pause