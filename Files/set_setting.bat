REM call settings.bat Setting Section var %var%
REM echo %1 %2 %3 %4
set "varname=%3"
set "new_state=%4"
if "%4"=="true" set "new_state=false"
if "%4"=="false" set "new_state=true"
call ini.bat /i %1 /s %2 /v %new_state% config\settings.ini >nul
set "%varname%=%new_state%"
REM echo %1 %2 %3 %4 %varname% %new_state%