@echo off
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
if %WINDOWSVER% LEQ 6 echo This script is not supported in your Windows version! Only Windows 10 and above is supported. Contact @schooi. on Discord for more info. Exiting.. & timeout /t 3 /NOBREAK >nul & exit
color 0f
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\start_fgrdown_after_rorl_ca.bat" del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\start_fgrdown_after_rorl_ca.bat"
title Fitgirl Repack Installer
if %WINDOWSVER% GEQ 10 set "g1=[38;5;214m"
if %WINDOWSVER% GEQ 10 set "g2=[38;5;215m"
if %WINDOWSVER% GEQ 10 set "g3=[38;5;216m"
if %WINDOWSVER% GEQ 10 set "g4=[38;5;217m"
if %WINDOWSVER% GEQ 10 set "g5=[38;5;218m"
if %WINDOWSVER% GEQ 10 set "g6=[38;5;219m"
call :logo
echo.
if %WINDOWSVER% GEQ 10 if not "%1"=="--download-list" if not exist pages CHOICE /C YN /T 15 /D Y /N /M "Would you like to get a list of all games and their magnet links? (Y/N)"
if %WINDOWSVER% GEQ 10 if not "%1"=="--download-list" if not exist pages IF %ERRORLEVEL% EQU 1 call :scraper
if "%1"=="--download-list" if not exist pages call :scraper
if not exist listviewer.bat powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/SchooiCodes/fgrdown/raw/refs/heads/main/listviewer.bat -OutFile listviewer.bat"
if not exist auto-install.txt if exist pages start "" "listviewer.bat"
if not exist "C:\Program Files\qbittorrent\qbittorrent.exe" echo An installation of qBittorrent was not found. Installing it now.. (this may take a long time)
if not exist "C:\Program Files\qbittorrent\qbittorrent.exe" powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://github.com/SchooiCodes/smt/raw/refs/heads/main/Files/Apps/qbt.bat -OutFile %TEMP%\qbt.bat" && start /MIN /WAIT "" "%TEMP%\qbt.bat" & del "%TEMP%\qbt.bat" & echo. 
if not exist auto-install.txt set /p magnet=Repack's %g1%m%g2%a%g3%g%g4%n%g5%e%g6%t[97m link ^> 
if exist auto-install.txt for /f "tokens=* delims=" %%a in (auto-install.txt) do (set magnet=%%a) & del auto-install.txt
set /p save_loc=Save %g1%l%g2%o%g2%c%g3%a%g4%t%g5%i%g5%o%g6%n[97m (full path, no \ (trailing backslash) in the end) ^> 
cls
call :logo
echo.
if "%magnet%"=="" echo Magnet link cannot be empty! & timeout /t 3 /NOBREAK >nul & exit
if not exist %save_loc% echo Specified location doesn't exist; creating "%save_loc%" now..
if not exist %save_loc% md %save_loc%
if %ERRORLEVEL% NEQ 0 echo Specified location is invalid! & timeout /t 3 /NOBREAK >nul & exit
echo Applying required settings..
tasklist /FI "IMAGENAME eq %processName%" 2>NUL | find /I /N "%processName%">NUL
if "%ERRORLEVEL%"=="0" echo echo %processName% is running. Killing it.. & taskkill /f /im qBittorrent.exe
if exist "%appdata%\qBittorrent_fgrdown" rd /s /q "%appdata%\qBittorrent_fgrdown"
md "%appdata%\qBittorrent_fgrdown"
echo [AutoRun]>"%appdata%\qBittorrent_fgrdown\qBittorrent.ini"
echo enabled=true>>"%appdata%\qBittorrent_fgrdown\qBittorrent.ini"
echo program=cmd /c \"taskkill /f /im qbittorrent.exe\">>"%appdata%\qBittorrent_fgrdown\qBittorrent.ini"
echo.
echo Downloading..
echo.
echo Legal Notice
echo qBittorrent is a file sharing program. When you run a torrent, its data will be made available to others by means of upload. Any content you share is your sole responsibility.
echo.
start /MIN /WAIT "" "C:\Program Files\qbittorrent\qbittorrent.exe" "%magnet%" --save-path="%save_loc%" --skip-dialog --configuration=fgrdown --confirm-legal-notice
rd /s /q "%localappdata%\qBittorrent_fgrdown\BT_backup"
echo Installing..
cd /d "%save_loc%"
dir | find /i "fitgirl" >nul && cd *[*]*
for %%a in (*.exe) do (start /wait "" "%%a" >nul) >nul
echo.
if %ERRORLEVEL% EQU 0 echo [92mSuccess[97m!
if %ERRORLEVEL% NEQ 0 echo An [91merror[97m has occured!
CHOICE /C YN /T 15 /D Y /N /M "Would you like to clean up the installer's files? (Y/N)"
if %ERRORLEVEL% EQU 1 set install_folder=%cd%
if not "%INSTALL_FOLDER%"=="" cd ..
if not "%INSTALL_FOLDER%"=="" rd /s /q "%install_folder%"
pause
exit

:scraper
python -V >nul 2>nul 2>&1
IF %ERRORLEVEL% EQU 9009 call :get_python
if not exist fgrscraper.py powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm 'https://raw.githubusercontent.com/SchooiCodes/fgrdown/refs/heads/main/fgrscraper.py' -OutFile fgrscraper.py"
echo Getting needed packages..
python.exe -m pip install --upgrade pip >nul
for %%P in (aiohttp asyncio bs4 lxml attrs) do (
    python -c "import %%P" 2>nul || (
        echo Installing %%P...
        pip install %%P >nul
    )
)
echo Generating list..
py fgrscraper.py
cls
call :logo
echo.
goto :EOF

:get_python
echo Downloading python's installer using IRM..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe -OutFile '%TEMP%\python.exe'"
echo Installing..
"%TEMP%\python.exe" InstallAllUsers=1 AssociateFiles=1 CompileAll=0 PrependPath=1 AppendPath=0 Shortcuts=1 Include_doc=1 Include_debug=0 Include_dev=1 Include_exe=1 Include_launcher=1 InstallLauncherAllUsers=0 Include_lib=1 Include_pip=1 Include_symbols=0 Include_tcltk=1 Include_test=0 Include_tools=1 LauncherOnly=0 SimpleInstall=1
echo Done!
del "%TEMP%\python.exe" >nul
CHOICE /C LRN /T 15 /D L /N /M "Log off / Restart needed! Would you like to [L]og Off, [R]estart, or Do [N]othing? "
if %ERRORLEVEL% EQU 1 echo @echo off ^& start "" "%~f0" --download-list ^& exit > "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\start_fgrdown_after_rorl_ca.bat" & shutdown -l
if %ERRORLEVEL% EQU 2 echo @echo off ^& start "" "%~f0" --download-list ^& exit > "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\start_fgrdown_after_rorl_ca.bat" & shutdown -r -t 10
if %ERRORLEVEL% EQU 3 echo Exiting.. please restart or log off manually and re-run the script.
timeout /t 5 /NOBREAK >nul
explorer "%~dp0"
exit

:logo
chcp 65001 >nul
echo %g1%███████╗ ██████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗███╗   ██╗
echo %g2%██╔════╝██╔════╝ ██╔══██╗██╔══██╗██╔═══██╗██║    ██║████╗  ██║
echo %g3%█████╗  ██║  ███╗██████╔╝██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║
echo %g4%██╔══╝  ██║   ██║██╔══██╗██║  ██║██║   ██║██║███╗██║██║╚██╗██║
echo %g5%██║     ╚██████╔╝██║  ██║██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║
echo %g6%╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝[97m
echo A tool for downloading ^& installing FitGirl Repacks - Made by @schooi
chcp 437 >nul