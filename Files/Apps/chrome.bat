@echo off
call logo.bat
title Chrome Installer
echo.
echo Chrome Installer
echo ==================
echo Installing..
powershell -Command "& { $Path = $env:TEMP; $Installer = 'chrome_installer.exe'; Invoke-WebRequest 'https://schooicodes.github.io/file_hosting/ChromeSetup.exe' -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -ArgumentList '/silent', '/install' -Verb RunAs -Wait; Remove-Item $Path\$Installer }"
if %ERRORLEVEL% EQU 0 (
    echo Success!
) else (
    echo Error: %ERRORLEVEL%
)
pause >nul
exit
