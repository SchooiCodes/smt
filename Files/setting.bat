REM call settings.bat flip/set Setting Section var %var%
REM echo %1 %2 %3 %4 %5
set "varname=%4"
set "new_state=%5"
if "%1"=="flip" (
	if "%5"=="true" set "new_state=false"
	if "%5"=="false" set "new_state=true"
	call :set %2 %3
) else if "%1"=="set" (
	call :set %2 %3
) else if "%1"=="get" (
	set "%3=na"
	FOR /F "tokens=* delims=" %%x in ('call ini.bat /i %2 /s %3 config\settings.ini') do set "%4=%%x"
)
goto :EOF

:set
call ini.bat /i %1 /s %2 /v %new_state% config\settings.ini >nul
set "%varname%=%new_state%"