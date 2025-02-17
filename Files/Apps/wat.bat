@echo off
title Winaero Tweaker Installer
if exist logo.bat call logo.bat & echo. 
echo Winaero Tweaker Installer
echo ==================
echo Downloading..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://winaerotweaker.com/download/winaerotweaker.zip -OutFile '%TEMP%\watinstaller.zip'"
echo Extracting..
md "%TEMP%\wat"
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path '%TEMP%\watinstaller.zip' -DestinationPath '%TEMP%\wat' -Force"
echo Installing..
cd %TEMP%\wat
for %%a in (*.exe) do ("%%a" /SP- /VERYSILENT >nul) >nul
cd ..
echo Done!
rd /s /q "%TEMP%\wat"
timeout /t 5 /NOBREAK >nul
exit