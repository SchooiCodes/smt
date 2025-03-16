@echo off
set name=%1
if %name%=="%name:~1,-1%" set "name=%name:~1,-1%"
if "%name%"=="" echo Missing app name! Exiting.. & timeout /t 5 /NOBREAK >nul & exit
set url=%3
if %url%=="%url:~1,-1%" set "url=%url:~1,-1%"
if "%url%"=="" echo Missing download URL! Exiting.. & timeout /t 5 /NOBREAK >nul & exit
if "%4"=="" echo Missing app shortname! Exiting.. & timeout /t 5 /NOBREAK >nul & exit
echo @echo off > "%USERPROFILE%\Downloads\%4.bat"
echo cd /d "%%~dp0" >> "%USERPROFILE%\Downloads\%4.bat"
echo if exist logo.bat call logo.bat ^& echo.  >> "%USERPROFILE%\Downloads\%4.bat"
echo title ^%name% Installer >> "%USERPROFILE%\Downloads\%4.bat"
echo echo ^%name% Installer >> "%USERPROFILE%\Downloads\%4.bat"
echo echo ================== >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo winget --version 2^>^&1 ^>nul >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo if NOT %%ERRORLEVEL%% EQU 0 goto irm >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo echo Installing via winget.. >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo winget install --accept-package-agreements --accept-source-agreements --disable-interactivity --force -e --id ^%2 >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo if %%ERRORLEVEL%% NEQ 0 goto irm >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo timeout /t 5 /NOBREAK ^>nul >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo exit >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo. >> "%USERPROFILE%\Downloads\%4.bat"
if NOT "%2"=="none" echo :irm >> "%USERPROFILE%\Downloads\%4.bat"
if "%2"=="none" (echo echo Package does not exist on winget! Using irm to download the installer and installing manually.. >> "%USERPROFILE%\Downloads\%4.bat") else (echo echo Winget not found! Falling back to using irm to download the installer and installing manually..>> "%USERPROFILE%\Downloads\%4.bat")
echo echo Downloading.. >> "%USERPROFILE%\Downloads\%4.bat"
echo powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '%3' -OutFile '%%TEMP%%\%4installer.exe'" >> "%USERPROFILE%\Downloads\%4.bat"
echo echo Installing.. >> "%USERPROFILE%\Downloads\%4.bat"
echo start /WAIT "" "%%TEMP%%\%4installer.exe" >> "%USERPROFILE%\Downloads\%4.bat"
echo echo Done! >> "%USERPROFILE%\Downloads\%4.bat"
echo del "%%TEMP%%\%4installer.exe" ^>nul >> "%USERPROFILE%\Downloads\%4.bat"
echo timeout /t 5 /NOBREAK ^>nul >> "%USERPROFILE%\Downloads\%4.bat"
echo exit >> "%USERPROFILE%\Downloads\%4.bat"