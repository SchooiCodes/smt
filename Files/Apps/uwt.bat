@echo off
title UWT Downloader
if exist logo.bat call logo.bat & echo. 
echo UWT Downloader
echo ==============
echo Getting zip file..
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul') do set build=%%a
if %build% GEQ 22000 (
	set UWT=5
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://www.thewindowsclub.com/downloads/UWT5.zip -OutFile '%TEMP%\UWT.zip'"
) else (
	set UWT=4
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://www.thewindowsclub.com/downloads/UWT4.zip -OutFile '%TEMP%\UWT.zip'"
)
echo Extracting zip..
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path '%TEMP%\UWT.zip' -DestinationPath '%USERPROFILE%\Desktop' -Force"
echo Starting..
cd %USERPROFILE%\Desktop
if "%UWT%"=="4" cd Ultimate Windows Tweaker 4*
if "%UWT%"=="5" cd UWT 5*
for %%a in (*.exe) do (start "" "%%a" >nul) >nul
echo Done. To "uninstall" delete the Ultimate Windows Tweaker folder on your Desktop.
timeout /t 5 /NOBREAK >nul
exit
