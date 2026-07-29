@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' %arg% 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd /d %~dp0
call ..\logo.bat
echo.
title ScHnuKEr ^| 2.0 ~ iNiTIalIzInG
if NOT EXIST Schnuker.py powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/SchooiCodes/Schnuker/refs/heads/main/Schnuker.py -OutFile Schnuker.py" 
goto :DOES_PYTHON_EXIST

:DOES_PYTHON_EXIST
python -V >nul 2>nul 2>&1
IF %ERRORLEVEL% EQU 9009 (call :get_python) else (goto PYTHON_DOES_EXIST)
pause
exit

:get_python
echo Downloading python's installer using IRM..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe -OutFile '%TEMP%\python.exe'"
echo Installing..
"%TEMP%\python.exe" InstallAllUsers=1 AssociateFiles=1 CompileAll=0 PrependPath=1 AppendPath=0 Shortcuts=1 Include_doc=1 Include_debug=0 Include_dev=1 Include_exe=1 Include_launcher=1 InstallLauncherAllUsers=0 Include_lib=1 Include_pip=1 Include_symbols=0 Include_tcltk=1 Include_test=0 Include_tools=1 LauncherOnly=0 SimpleInstall=1
echo Done!
del "%TEMP%\python.exe" >nul
CHOICE /C LRN /T 15 /D L /N /M "Log off / Restart needed! Would you like to [L]og Off, [R]estart, or Do [N]othing? "
if %ERRORLEVEL% EQU 1 shutdown -l
if %ERRORLEVEL% EQU 2 shutdown -r -t 10
if %ERRORLEVEL% EQU 3 echo Exiting.. please restart or log off manually and re-run the script.
timeout /t 5 /NOBREAK >nul
explorer "%~dp0"
exit

:PYTHON_DOES_EXIST
echo Checking for libraries..
for %%P in (discord colorama asyncio) do (
    python -c "import %%P" 2>nul || (
        echo Installing %%P...
        pip install %%P >nul
    )
)
echo Starting...
py Schnuker.py
exit
