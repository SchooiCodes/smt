@echo off
cls
cd pages
title FGRDown List Viewer
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
if %WINDOWSVER% LEQ 6 echo This script is not supported in your Windows version! Only Windows 10 and above is supported. Contact @schooi. on Discord for more info. Exiting.. & timeout /t 3 /NOBREAK >nul & exit
if %WINDOWSVER% GEQ 10 set "g1=[38;5;214m"
if %WINDOWSVER% GEQ 10 set "g2=[38;5;215m"
if %WINDOWSVER% GEQ 10 set "g3=[38;5;216m"
if %WINDOWSVER% GEQ 10 set "g4=[38;5;217m"
if %WINDOWSVER% GEQ 10 set "g5=[38;5;218m"
if %WINDOWSVER% GEQ 10 set "g6=[38;5;219m"
setlocal enabledelayedexpansion

:main
cls
call :logo
echo.
echo =====================================
echo          Game List Viewer
echo =====================================
echo.
for /f "tokens=1 delims= " %%f in ('dir ^| find "File(s)"') do (set max=%%f)
set /p "page=Enter page number to view (1-%max%) or / to search: "
if "%page%"=="/" set /p search=Search term: 
echo.
if not "%search%"=="" for /f "tokens=1,2,3,4,5,6,* delims=" %%a in ('findstr /i /c:"%search%" *.txt') do (
	for /f "tokens=* delims=;^|" %%b in ("%%a") do (
		for /f "tokens=2 delims=:;^|" %%c in ("%%b") do (
			<nul set /p "=Page %%c: "
		)
		for /f "tokens=2 delims=;" %%d in ("%%b") do (
			<nul set /p "=%%d) "
		)
		for /f "tokens=3 delims=;^|" %%e in ("%%b") do (
			echo %%e
		)
		echo.
	)
)
if not "%search%"=="" set "search=" & pause & goto main
if NOT "%page%"=="/" if not exist %page%.txt (
    echo Page not found.
    pause
    goto main
)

:page
cls
call :logo
echo.
echo Showing games from page %page%..
echo =====================================
set "counter=0"
echo B) Go Back
for /f "tokens=3 delims=;^|" %%a in (%page%.txt) do (
	set /a counter+=1
	echo !counter!^) %%a
    )
)
echo.
set /p "game=Enter the number of the game to automatically download and install it or B to go back: "
if /i "%game%"=="B" goto main
if /i "%game%"=="" goto page
set "counter=0"
set "found=0"
for /f "tokens=2 delims=;^|" %%a in (%page%.txt) do (
	if "%page%;%%a"=="%page%;%game%" (
		set "found=1"
	)
    if "!found!"=="1" (
        for /f "tokens=4 delims=;^|" %%c in ('findstr /c:"%page%;%game%" %page%.txt') do (
			echo.
            echo Automatically installing..
			for /f "tokens=2 delims=," %%a in ('tasklist /fi "windowtitle eq Fitgirl Repack Installer" /fo csv /nh') do (
				taskkill /f /pid %%a >nul
			)
			cd ..
			start "" "fgrdown.bat"
			cd pages
			echo %%c>"..\auto-install.txt"
			timeout /t 5 /NOBREAK >nul
			goto main
        )
    )
)
pause
goto page

:logo
chcp 65001 >nul
echo %g1%███████╗ ██████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗███╗   ██╗
echo %g2%██╔════╝██╔════╝ ██╔══██╗██╔══██╗██╔═══██╗██║    ██║████╗  ██║
echo %g3%█████╗  ██║  ███╗██████╔╝██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║
echo %g4%██╔══╝  ██║   ██║██╔══██╗██║  ██║██║   ██║██║███╗██║██║╚██╗██║
echo %g5%██║     ╚██████╔╝██║  ██║██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║
echo %g6%╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝[97m
echo A tool for downloading ^& installing FitGirl Repacks - Made by @schooi