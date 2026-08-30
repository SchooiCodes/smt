@echo off
cd /d "%~dp0"
title [SMT] Portable Creator
if exist logo.bat call logo.bat & echo.
echo Creating a SMT portable in "%USERPROFILE%\Downloads\smt"..
if not exist "%USERPROFILE%\Downloads\smt\Files\config" (echo Folder doesn't exist, creating it.. & md "%USERPROFILE%\Downloads\smt\Files\config") else (echo Folder exists, wiping it.. & rd /s /q "%USERPROFILE%\Downloads\smt" & md "%USERPROFILE%\Downloads\smt\Files\config")
echo Copying sync.bat into the folder..
copy sync.bat "%USERPROFILE%\Downloads\smt\Files\" >nul
echo Copying settings.ini into the folder..
copy config\settings.ini "%USERPROFILE%\Downloads\smt\Files\config\" >nul
cd %USERPROFILE%\Downloads\smt\Files
echo Applying new config.. (isportable=true, usagepingsent=false, addedtopath=false)
call "%~dp0ini.bat" /i isportable /s Portable /v true config\settings.ini >nul
call "%~dp0ini.bat" /i usagepingsent /s Telemetry /v false config\settings.ini >nul
call "%~dp0ini.bat" /i smtinpath /s AddedToPath /v false config\settings.ini >nul
echo Starting filesync..
start /WAIT cmd /c "sync.bat createport"
echo Zipping..
powershell $ProgressPreference = 'SilentlyContinue'; Compress-Archive -Path "%USERPROFILE%\Downloads\smt\*" -DestinationPath "%USERPROFILE%\Downloads\smt.zip" -Force
echo Deleting "%USERPROFILE%\Downloads\smt"..
cd %USERPROFILE%\Downloads
rd /s /q "%USERPROFILE%\Downloads\smt"
echo Done! If everything went correctly, "%USERPROFILE%\Downloads\smt.zip" should be a functional SMT portable!
pause
exit