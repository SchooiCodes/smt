@echo off
if not exist "%TEMP%\inputs.bat" (
	echo echo.>>%TEMP%\inputs.bat
	echo echo Please paste the first line of your ASCII art: >>%TEMP%\inputs.bat
	echo set /p l1=>>%TEMP%\inputs.bat
	echo echo Please paste the second line of your ASCII art: >>%TEMP%\inputs.bat
	echo set /p l2=>>%TEMP%\inputs.bat
	echo echo Please paste the third line of your ASCII art: >>%TEMP%\inputs.bat
	echo set /p l3=>>%TEMP%\inputs.bat
	echo echo Please paste the fourth line of your ASCII art: >>%TEMP%\inputs.bat
	echo set /p l4=>>%TEMP%\inputs.bat
	echo echo Please paste the fifth line of your ASCII art: >>%TEMP%\inputs.bat
	echo set /p l5=>>%TEMP%\inputs.bat
	echo echo Please paste the sixth line of your ASCII art: >>%TEMP%\inputs.bat
	echo set /p l6=>>%TEMP%\inputs.bat
)
cls
title Gradient Maker ^| v1.0
call :logo
echo.
echo Gradient Maker v1.0
echo ====================
echo Would you like to make [38;5;214mg[38;5;215mr[38;5;215ma[38;5;216md[38;5;217mi[38;5;218me[38;5;218mn[38;5;219mt[38;5;219ms[97m or use [94mstatic colors[97m? {G/S}
set /p type=^> 
if /i "%type%"=="g" goto gradients
if /i "%type%"=="s" goto static

:static
cls
title Gradient Maker ^| v1.0
call :logo
echo.
echo Gradient Maker v1.0
echo ====================
echo ONLY 6 LINE ASCII ART IS SUPPORTED!
echo TO GENERATE 6 LINE ASCII ART: https://bit.ly/6linetallascii
echo Which color would you like it to be?
echo [97m[1] [31mRed[97m, [2] [32mGreen[97m, [3] [33mYellow[97m, [4] [34mBlue[97m, [5] [35mMagenta[97m
echo [6] [36mCyan[97m, [7] [90mGray[97m, [8] [91mBright Red[97m, [9] [92mBright Green[97m, [10] [93mBright Yellow[97m
echo [11] [94mBright Blue[97m, [12] [95mBright Magenta[97m, [13] [96mBright Cyan[97m, [14] White
set /p choice=^> 
goto %choice%
goto static

:1
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[31m%l1%"
set "l2=echo ^<escape^>[31m%l2%"
set "l3=echo ^<escape^>[31m%l3%"
set "l4=echo ^<escape^>[31m%l4%"
set "l5=echo ^<escape^>[31m%l5%"
set "l6=echo ^<escape^>[31m%l6%^<escape^>[0m"
call :scagss

:2
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[32m%l1%"
set "l2=echo ^<escape^>[32m%l2%"
set "l3=echo ^<escape^>[32m%l3%"
set "l4=echo ^<escape^>[32m%l4%"
set "l5=echo ^<escape^>[32m%l5%"
set "l6=echo ^<escape^>[32m%l6%^<escape^>[0m"
call :scagss

:3
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[33m%l1%"
set "l2=echo ^<escape^>[33m%l2%"
set "l3=echo ^<escape^>[33m%l3%"
set "l4=echo ^<escape^>[33m%l4%"
set "l5=echo ^<escape^>[33m%l5%"
set "l6=echo ^<escape^>[33m%l6%^<escape^>[0m"
call :scagss

:4
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[34m%l1%"
set "l2=echo ^<escape^>[34m%l2%"
set "l3=echo ^<escape^>[34m%l3%"
set "l4=echo ^<escape^>[34m%l4%"
set "l5=echo ^<escape^>[34m%l5%"
set "l6=echo ^<escape^>[34m%l6%^<escape^>[0m"
call :scagss

:5
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[35m%l1%"
set "l2=echo ^<escape^>[35m%l2%"
set "l3=echo ^<escape^>[35m%l3%"
set "l4=echo ^<escape^>[35m%l4%"
set "l5=echo ^<escape^>[35m%l5%"
set "l6=echo ^<escape^>[35m%l6%^<escape^>[0m"
call :scagss

:6
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[36m%l1%"
set "l2=echo ^<escape^>[36m%l2%"
set "l3=echo ^<escape^>[36m%l3%"
set "l4=echo ^<escape^>[36m%l4%"
set "l5=echo ^<escape^>[36m%l5%"
set "l6=echo ^<escape^>[36m%l6%^<escape^>[0m"
call :scagss

:7
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[90m%l1%"
set "l2=echo ^<escape^>[90m%l2%"
set "l3=echo ^<escape^>[90m%l3%"
set "l4=echo ^<escape^>[90m%l4%"
set "l5=echo ^<escape^>[90m%l5%"
set "l6=echo ^<escape^>[90m%l6%^<escape^>[0m"
call :scagss

:8
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[91m%l1%"
set "l2=echo ^<escape^>[91m%l2%"
set "l3=echo ^<escape^>[91m%l3%"
set "l4=echo ^<escape^>[91m%l4%"
set "l5=echo ^<escape^>[91m%l5%"
set "l6=echo ^<escape^>[91m%l6%^<escape^>[0m"
call :scagss

:9
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[92m%l1%"
set "l2=echo ^<escape^>[92m%l2%"
set "l3=echo ^<escape^>[92m%l3%"
set "l4=echo ^<escape^>[92m%l4%"
set "l5=echo ^<escape^>[92m%l5%"
set "l6=echo ^<escape^>[92m%l6%^<escape^>[0m"
call :scagss

:10
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[93m%l1%"
set "l2=echo ^<escape^>[93m%l2%"
set "l3=echo ^<escape^>[93m%l3%"
set "l4=echo ^<escape^>[93m%l4%"
set "l5=echo ^<escape^>[93m%l5%"
set "l6=echo ^<escape^>[93m%l6%^<escape^>[0m"
call :scagss

:11
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[94m%l1%"
set "l2=echo ^<escape^>[94m%l2%"
set "l3=echo ^<escape^>[94m%l3%"
set "l4=echo ^<escape^>[94m%l4%"
set "l5=echo ^<escape^>[94m%l5%"
set "l6=echo ^<escape^>[94m%l6%^<escape^>[0m"
call :scagss

:12
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[95m%l1%"
set "l2=echo ^<escape^>[95m%l2%"
set "l3=echo ^<escape^>[95m%l3%"
set "l4=echo ^<escape^>[95m%l4%"
set "l5=echo ^<escape^>[95m%l5%"
set "l6=echo ^<escape^>[95m%l6%^<escape^>[0m"
call :scagss

:13
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[96m%l1%"
set "l2=echo ^<escape^>[96m%l2%"
set "l3=echo ^<escape^>[96m%l3%"
set "l4=echo ^<escape^>[96m%l4%"
set "l5=echo ^<escape^>[96m%l5%"
set "l6=echo ^<escape^>[96m%l6%^<escape^>[0m"
call :scagss

:14
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[97m%l1%"
set "l2=echo ^<escape^>[97m%l2%"
set "l3=echo ^<escape^>[97m%l3%"
set "l4=echo ^<escape^>[97m%l4%"
set "l5=echo ^<escape^>[97m%l5%"
set "l6=echo ^<escape^>[97m%l6%^<escape^>[0m"
call :scagss

:gradients
cls
title Gradient Maker ^| v1.0
call :logo
echo.
echo Gradient Maker v1.0
echo ====================
echo ONLY 6 LINE ASCII ART IS SUPPORTED!
echo TO GENERATE 6 LINE ASCII ART: https://bit.ly/6linetallascii
echo Which color would you like it to be?
echo [1] [38;5;214mOrange[97m --^> [38;5;219mPink[97m, [2] [38;5;40mGreen[97m --^> [38;5;45mBright Blue[97m, [3] [38;5;33mBlue[97m --^> [38;5;213mPink[97m [4] [38;5;196mRed[97m --^> [38;5;201mPink[97m [5] [38;5;46mGreen[97m --^> [38;5;226mYellow[97m
echo [6] [38;5;51mBlue[97m -^> [38;5;226mYellow[97m, [7] [38;2;135;206;250mLight Blue[97m -^> [38;2;35;106;200mBlue[97m
set /p choice=^> 
if %choice%==1 goto otp
if %choice%==2 goto gtbb
if %choice%==3 goto dbtp
if %choice%==4 goto rtp
if %choice%==5 goto gty
if %choice%==6 goto bty
if %choice%==7 goto bbtb
goto gradients


:otp
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[38;5;214m%l1%"
set "l2=echo ^<escape^>[38;5;215m%l2%"
set "l3=echo ^<escape^>[38;5;216m%l3%"
set "l4=echo ^<escape^>[38;5;217m%l4%"
set "l5=echo ^<escape^>[38;5;218m%l5%"
set "l6=echo ^<escape^>[38;5;219m%l6%^<escape^>[0m"
call :scags

:gtbb
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[38;5;46m%l1%"
set "l2=echo ^<escape^>[38;5;47m%l2%"
set "l3=echo ^<escape^>[38;5;48m%l3%"
set "l4=echo ^<escape^>[38;5;49m%l4%"
set "l5=echo ^<escape^>[38;5;50m%l5%"
set "l6=echo ^<escape^>[38;5;51m%l6%^<escape^>[0m"
call :scags

:dbtp
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[38;5;33m%l1%"
set "l2=echo ^<escape^>[38;5;69m%l2%"
set "l3=echo ^<escape^>[38;5;105m%l3%"
set "l4=echo ^<escape^>[38;5;141m%l4%"
set "l5=echo ^<escape^>[38;5;177m%l5%"
set "l6=echo ^<escape^>[38;5;213m%l6%^<escape^>[0m"
call :scags

:rtp
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[38;5;196m%l1%"
set "l2=echo ^<escape^>[38;5;197m%l2%"
set "l3=echo ^<escape^>[38;5;198m%l3%"
set "l4=echo ^<escape^>[38;5;199m%l4%"
set "l5=echo ^<escape^>[38;5;200m%l5%"
set "l6=echo ^<escape^>[38;5;201m%l6%^<escape^>[0m"
call :scags

:gty
call :input
set "l1=echo ^<escape^>[38;5;46m%l1%"
set "l2=echo ^<escape^>[38;5;82m%l2%"
set "l3=echo ^<escape^>[38;5;118m%l3%"
set "l4=echo ^<escape^>[38;5;154m%l4%"
set "l5=echo ^<escape^>[38;5;190m%l5%"
set "l6=echo ^<escape^>[38;5;226m%l6%^<escape^>[0m"
call :scags

:bty
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[38;5;51m%l1%"
set "l2=echo ^<escape^>[38;5;86m%l2%"
set "l3=echo ^<escape^>[38;5;121m%l3%"
set "l4=echo ^<escape^>[38;5;156m%l4%"
set "l5=echo ^<escape^>[38;5;191m%l5%"
set "l6=echo ^<escape^>[38;5;226m%l6%^<escape^>[0m"
call :scags

:bbtb
call "%TEMP%\inputs.bat"
set "l1=echo ^<escape^>[38;2;135;206;250m%l1%"
set "l2=echo ^<escape^>[38;2;115;186;240m%l2%"
set "l3=echo ^<escape^>[38;2;95;166;230m%l3%"
set "l4=echo ^<escape^>[38;2;75;146;220m%l4%"
set "l5=echo ^<escape^>[38;2;55;126;210m%l5%"
set "l6=echo ^<escape^>[38;2;35;106;200m%l6%^<escape^>[0m"
call :scags

:scags
echo.
echo Commands for the gradient
echo (Replace ^<escape^> in each line with the escape character, which will be provided to you later in the script)
echo ------------------------------------------------------------------------------------------------------
echo @echo off
echo chcp 65001 ^>nul
echo %l1%
echo %l2%
echo %l3%
echo %l4%
echo %l5%
echo %l6%
echo chcp 437 ^>nul
echo ------------------------------------------------------------------------------------------------------
echo.
echo Would you like to copy the escape character? [y]/[N]
set /p copyesc=^> 
if /i "%copyesc%"=="y" @Set /P "="<NUL|Clip
goto gradients 

:scagss
echo.
echo Commands for the colored ASCII art
echo (Replace ^<escape^> in each line with the escape character, which will be provided to you later in the script)
echo ------------------------------------------------------------------------------------------------------
echo @echo off
echo chcp 65001 ^>nul
echo %l1%
echo %l2%
echo %l3%
echo %l4%
echo %l5%
echo %l6%
echo chcp 437 ^>nul
echo ------------------------------------------------------------------------------------------------------
echo.
echo Would you like to copy the escape character? [y]/[N]
set /p copyesc=^> 
if /i "%copyesc%"=="y" @Set /P "="<NUL|Clip
goto static

:logo
for /f "tokens=2,*delims=:" %%i in ('chcp') do set /a oldcp =%%i
chcp 65001 >nul
echo/[38;5;214m░██████╗░██████╗░░█████╗░██████╗░██╗███████╗███╗░░██╗████████╗░██████╗
echo/[38;5;214m██╔════╝░██╔══██╗██╔══██╗██╔══██╗██║██╔════╝████╗░██║╚══██╔══╝██╔════╝
echo/[38;5;215m██║░░██╗░██████╔╝███████║██║░░██║██║█████╗░░██╔██╗██║░░░██║░░░╚█████╗░
echo/[38;5;215m██║░░╚██╗██╔══██╗██╔══██║██║░░██║██║██╔══╝░░██║╚████║░░░██║░░░░╚═══██╗
echo/[38;5;216m╚██████╔╝██║░░██║██║░░██║██████╔╝██║███████╗██║░╚███║░░░██║░░░██████╔╝
echo/[38;5;216m░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░
echo/[38;5;217m░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░████████╗░█████╗░██████╗░
echo/[38;5;217m██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗
echo/[38;5;218m██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║░░░██║░░░██║░░██║██████╔╝
echo/[38;5;218m██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║░░░██║░░░██║░░██║██╔══██╗
echo/[38;5;219m╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║░░░██║░░░╚█████╔╝██║░░██║
echo/[38;5;219m░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝[97m (by @schooi. on discord)
chcp %oldcp% >nul
