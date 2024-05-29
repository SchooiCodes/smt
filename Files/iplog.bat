@echo off
title IP Logs - V4  // User: %USERNAME%  //  Time: %TIME%  //  Date: %DATE%
mode con lines=24 cols=78
:reset
cls
set /a color=(%Random%%%7)+1
echo [40;3%color%m
echo.
echo         8888888               888                                
echo           888                 888                                
echo           888                 888                                
echo           888   88888b.       888      .d88b.   .d88b.  .d8888b  
echo           888   888 "88b      888     d88""88b d88P"88b 88K      
echo           888   888  888      888     888  888 888  888 "Y8888b. 
echo           888   888 d88P      888     Y88..88P Y88b 888      X88 
echo         8888888 88888P"       88888888 "Y88P"   "Y88888  88888P' 
echo                 888                                 888          
echo                 888                            Y8b d88P          
echo                 888                             "Y88P"   
echo.
echo       [40;37m^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>[40;30m
echo       [40;37m^<^>[40;33m Press 1 to open IP Logs Database [40;37m~[40;33m Made by RavelCros_Cro [40;37m^<^>
echo       [40;37m^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<[40;30m
echo.[40;37m
set /p name=[40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;36mPRESS 1 OR ENTER TARGET NAME:[40;31m 
echo.
if %name% == 1 goto open
set /p IP=[40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;36mENTER %name%'s IP:[40;31m 
echo -  %name%  //  %IP%  -  %date% %time%>> IPLogs.txt
echo.
echo [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;37m[40;37m{+}- [40;33m%name%'s Info Saved in Your Database [40;37m-{+}
echo [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;30m [40;37m[40;37m{+}- [40;33mPress Any Key to Restart IP Logs [40;37m-{+}
pause >nul
goto reset
:open
cls
start IPLogs.txt
goto reset

