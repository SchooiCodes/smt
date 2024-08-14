@echo off
title Info Grabber v1.0
echo Info Grabber - Saving..
echo ================
echo.
cd /d "%~dp0"
md GrabbedInfo >nul 2>&1
cd GrabbedInfo
set olddir=%cd%
echo IP Info >> "%USERNAME%'s Info.txt"
echo --------- >> "%USERNAME%'s Info.txt"
ipconfig >> "%USERNAME%'s Info.txt"
echo. >> "%USERNAME%'s Info.txt"
echo User Info >> "%USERNAME%'s Info.txt"
echo --------- >> "%USERNAME%'s Info.txt"
net user >> "%USERNAME%'s Info.txt"
echo. >> "%USERNAME%'s Info.txt"
echo System Info >> "%USERNAME%'s Info.txt"
echo --------- >> "%USERNAME%'s Info.txt"
systeminfo >> "%USERNAME%'s Info.txt"
echo. >> "%USERNAME%'s Info.txt"
echo C:\ contents >> "%USERNAME%'s Info.txt"
echo --------- >> "%USERNAME%'s Info.txt"
cd C:\
dir >> "%olddir%\%USERNAME%'s Info.txt"
echo. >> "%olddir%\%USERNAME%'s Info.txt"
echo Program Files contents >> "%olddir%\%USERNAME%'s Info.txt"
echo ------------------------- >> "%olddir%\%USERNAME%'s Info.txt"
cd "C:\Program Files"
dir  >> "%olddir%\%USERNAME%'s Info.txt"
echo. >> "%olddir%\%USERNAME%'s Info.txt"
echo Program Files x86 contents >> "%olddir%\%USERNAME%'s Info.txt"
echo ------------------------- >> "%olddir%\%USERNAME%'s Info.txt"
cd "C:\Program Files (x86)"
dir  >> "%olddir%\%USERNAME%'s Info.txt"
echo Copied %USERNAME%'s info to "%olddir%\%USERNAME%'s Info.txt"
pause >nul
exit
