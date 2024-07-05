@echo off
call ..\logo.bat
echo.
title ScHnuKEr ^| 2.0 ~ iNiTIalIzInG
goto :DOES_PYTHON_EXIST

:DOES_PYTHON_EXIST
python -V | find /v "Python" >NUL 2>NUL && (goto :PYTHON_DOES_NOT_EXIST)
python -V | find "Python"    >NUL 2>NUL && (goto :PYTHON_DOES_EXIST)
pause
exit

:PYTHON_DOES_NOT_EXIST
echo Python is not installed on your system.
echo Now opening the download URL.
start "" "https://www.python.org/downloads/windows/"
pause
exit

:PYTHON_DOES_EXIST
echo Checking for libraries..
pip install discord >nul
pip install colorama >nul
pip install asyncio >nul
echo Starting...
start Schnuker.py
exit