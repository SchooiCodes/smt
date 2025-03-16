@echo off
title App Installer Generator
if not exist Apps\ait.bat powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm '"https://raw.githubusercontent.com/SchooiCodes/smt/refs/heads/main/Files/Apps/ait.bat"' -OutFile 'Apps\ait.bat'" 
if exist logo.bat call logo.bat & echo.  
echo App Installer Generator
echo ========================
set /p app=Please type the app's name: 
set /p winget=Does the app exist on winget? [Y/N] 
if /i "%winget%"=="y" set /p wid=Please type the app's winget ID: 
if /i NOT "%winget%"=="y" set wid=none
set /p url=Please type the app's installer URL for devices that don't have winget (eg. https://example.com/file.exe): 
set /p sn=Please type the app's short name (eg. IrfanView becomes ifv): 
call Apps\ait "%app%" %wid% "%url%" %sn%
echo Done! If everything went correctly, a file (%USERPROFILE%\Downloads\%sn%.bat) was generated.
timeout /t 5 /NOBREAK >nul
exit