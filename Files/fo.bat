@echo off
setlocal enabledelayedexpansion

:start
cls
if exist logo.bat call logo.bat & echo.
echo Which directory would you like to organize?
set /p dir=^> 
echo Organizing files in %dir%
echo.
cd /d "%dir%"
REM Create folders based on file extension and move files
for %%f in (*.*) do (
    set "ext=%%~xf"
    REM Remove the dot from the extension
    set "extwd=!ext:.=!"
    REM Check if the extension is not empty
    if not "!extwd!"=="" (
        if not exist "%dir%\!extwd!\" mkdir "%dir%\!extwd!"
        move "%%f" "%dir%\!extwd!\"
    )
)

echo.
echo Files have been organized.
echo Press any key to continue...
pause >nul
goto start
