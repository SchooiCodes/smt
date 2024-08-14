@echo off
goto elevate

:start
cd /d "%~dp0"
cls
call logo.bat
title Website Blocker
echo.
echo Website Blocker
echo =================
echo What would you like to do? [B]lock/[E]dit
set /p choice=^> 
if /i %choice%==B goto block
if /i %choice%==E goto edit
goto start

:block
cls
cd /d "%~dp0"
call logo.bat
title Website Blocker
echo.
echo Website Blocker
echo =================
cd C:\Windows\System32\drivers\etc
echo Type 1 to go back.
echo What is the name of the website you would like to block?
echo Please enter the name without "www." (like google.com instead of www.google.com)
set /p block=^> 
if %block%==1 goto start
if NOT EXIST hosts call createhosts
echo 127.0.0.1 %block%>>hosts
echo 127.0.0.1 www.%block%>>hosts
ipconfig /flushdns >nul
goto block

:edit
cd C:\Windows\System32\drivers\etc
notepad hosts
goto start

:createhosts
echo # Copyright (c) 1993-2009 Microsoft Corp.>>hosts
echo #>>hosts
echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.>>hosts
echo #>>hosts
echo # This file contains the mappings of IP addresses to host names. Each>>hosts
echo # entry should be kept on an individual line. The IP address should>>hosts
echo # be placed in the first column followed by the corresponding host name.>>hosts
echo # The IP address and the host name should be separated by at least one>>hosts
echo # space.>>hosts
echo #>>hosts
echo # Additionally, comments (such as these) may be inserted on individual>>hosts
echo # lines or following the machine name denoted by a '#' symbol.>>hosts
echo #>>hosts
echo # For example:>>hosts
echo #>>hosts
echo #      102.54.94.97     rhino.acme.com          # source server>>hosts
echo #      38.25.63.10     x.acme.com              # x client host>>hosts
echo >>hosts
echo # localhost name resolution is handled within DNS itself.>>hosts
echo # 127.0.0.1       localhost>>hosts
echo # ::1             localhost>>hosts
goto start

:elevate
fltmc >nul 2>&1 || (
    PowerShell -Command "Start-Process '%0' -Verb RunAs" || (
        >nul pause && exit 1
    )
    exit 0
)
goto start
