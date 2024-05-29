@echo off
call logo.bat
title SuperF4 Installer
echo.
echo SuperF4 Installer
echo ==================
echo Installing..
powershell -Command "& { $Path = $env:TEMP; $Installer = 'SuperF4.exe'; Invoke-WebRequest 'https://schooicodes.github.io/file_hosting/SuperF4.exe' -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -ArgumentList '/silent', '/install' -Verb RunAs -Wait; Remove-Item $Path\$Installer }"
if %ERRORLEVEL% EQU 0 (
    echo Success!
) else (
    echo Error: %ERRORLEVEL%
)
pause >nul
exit
