@echo off

:start
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
echo [6] [38;5;51mBlue[97m -^> [38;5;226mYellow[97m, [38;2;135;206;250mLight Blue[97m -^> [38;2;35;106;200mBlue[97m
set /p choice=^> 
if %choice%==1 goto otp
if %choice%==2 goto gtbb
if %choice%==3 goto dbtp
if %choice%==4 goto rtp
if %choice%==5 goto gty
if %choice%==6 goto bty
if %choice%==7 goto bbtb
goto start


:otp
echo.
echo Please paste the first line of your ASCII art: 
set /p l1=^> 
set "l1=echo ^<escape^>[38;5;214m%l1%"
echo Please paste the second line of your ASCII art: 
set /p l2=^> 
set "l2=echo ^<escape^>[38;5;215m%l2%"
echo Please paste the third line of your ASCII art: 
set /p l3=^> 
set "l3=echo ^<escape^>[38;5;216m%l3%"
echo Please paste the fourth line of your ASCII art: 
set /p l4=^> 
set "l4=echo ^<escape^>[38;5;217m%l4%"
echo Please paste the fifth line of your ASCII art: 
set /p l5=^> 
set "l5=echo ^<escape^>[38;5;218m%l5%"
echo Please paste the sixth line of your ASCII art: 
set /p l6=^> 
set "l6=echo ^<escape^>[38;5;219m%l6%^<escape^>[0m"
call :scags

:gtbb
echo.
echo Please paste the first line of your ASCII art: 
set /p l1=^> 
set "l1=echo ^<escape^>[38;5;46m%l1%"
echo Please paste the second line of your ASCII art: 
set /p l2=^> 
set "l2=echo ^<escape^>[38;5;47m%l2%"
echo Please paste the third line of your ASCII art: 
set /p l3=^> 
set "l3=echo ^<escape^>[38;5;48m%l3%"
echo Please paste the fourth line of your ASCII art: 
set /p l4=^> 
set "l4=echo ^<escape^>[38;5;49m%l4%"
echo Please paste the fifth line of your ASCII art: 
set /p l5=^> 
set "l5=echo ^<escape^>[38;5;50m%l5%"
echo Please paste the sixth line of your ASCII art: 
set /p l6=^> 
set "l6=echo ^<escape^>[38;5;51m%l6%^<escape^>[0m"
call :scags

:dbtp
echo.
echo Please paste the first line of your ASCII art: 
set /p l1=^> 
set "l1=echo ^<escape^>[38;5;33m%l1%"
echo Please paste the second line of your ASCII art: 
set /p l2=^> 
set "l2=echo ^<escape^>[38;5;69m%l2%"
echo Please paste the third line of your ASCII art: 
set /p l3=^> 
set "l3=echo ^<escape^>[38;5;105m%l3%"
echo Please paste the fourth line of your ASCII art: 
set /p l4=^> 
set "l4=echo ^<escape^>[38;5;141m%l4%"
echo Please paste the fifth line of your ASCII art: 
set /p l5=^> 
set "l5=echo ^<escape^>[38;5;177m%l5%"
echo Please paste the sixth line of your ASCII art: 
set /p l6=^> 
set "l6=echo ^<escape^>[38;5;213m%l6%^<escape^>[0m"
call :scags

:rtp
echo.
echo Please paste the first line of your ASCII art: 
set /p l1=^> 
set "l1=echo ^<escape^>[38;5;196m%l1%"
echo Please paste the second line of your ASCII art: 
set /p l2=^> 
set "l2=echo ^<escape^>[38;5;197m%l2%"
echo Please paste the third line of your ASCII art: 
set /p l3=^> 
set "l3=echo ^<escape^>[38;5;198m%l3%"
echo Please paste the fourth line of your ASCII art: 
set /p l4=^> 
set "l4=echo ^<escape^>[38;5;199m%l4%"
echo Please paste the fifth line of your ASCII art: 
set /p l5=^> 
set "l5=echo ^<escape^>[38;5;200m%l5%"
echo Please paste the sixth line of your ASCII art: 
set /p l6=^> 
set "l6=echo ^<escape^>[38;5;201m%l6%^<escape^>[0m"
call :scags

:gty
echo.
echo Please paste the first line of your ASCII art: 
set /p l1=^> 
set "l1=echo ^<escape^>[38;5;46m%l1%"
echo Please paste the second line of your ASCII art: 
set /p l2=^> 
set "l2=echo ^<escape^>[38;5;82m%l2%"
echo Please paste the third line of your ASCII art: 
set /p l3=^> 
set "l3=echo ^<escape^>[38;5;118m%l3%"
echo Please paste the fourth line of your ASCII art: 
set /p l4=^> 
set "l4=echo ^<escape^>[38;5;154m%l4%"
echo Please paste the fifth line of your ASCII art: 
set /p l5=^> 
set "l5=echo ^<escape^>[38;5;190m%l5%"
echo Please paste the sixth line of your ASCII art: 
set /p l6=^> 
set "l6=echo ^<escape^>[38;5;226m%l6%^<escape^>[0m"
call :scags

:bty
echo.
echo Please paste the first line of your ASCII art: 
set /p l1=^> 
set "l1=echo ^<escape^>[38;5;51m%l1%"
echo Please paste the second line of your ASCII art: 
set /p l2=^> 
set "l2=echo ^<escape^>[38;5;86m%l2%"
echo Please paste the third line of your ASCII art: 
set /p l3=^> 
set "l3=echo ^<escape^>[38;5;121m%l3%"
echo Please paste the fourth line of your ASCII art: 
set /p l4=^> 
set "l4=echo ^<escape^>[38;5;156m%l4%"
echo Please paste the fifth line of your ASCII art: 
set /p l5=^> 
set "l5=echo ^<escape^>[38;5;191m%l5%"
echo Please paste the sixth line of your ASCII art: 
set /p l6=^> 
set "l6=echo ^<escape^>[38;5;226m%l6%^<escape^>[0m"
call :scags

:bbtb
echo.
echo Please paste the first line of your ASCII art: 
set /p l1=^> 
set "l1=echo ^<escape^>[38;2;135;206;250m%l1%"
echo Please paste the second line of your ASCII art: 
set /p l2=^> 
set "l2=echo ^<escape^>[38;2;115;186;240m%l2%"
echo Please paste the third line of your ASCII art: 
set /p l3=^> 
set "l3=echo ^<escape^>[38;2;95;166;230m%l3%"
echo Please paste the fourth line of your ASCII art: 
set /p l4=^> 
set "l4=echo ^<escape^>[38;2;75;146;220m%l4%"
echo Please paste the fifth line of your ASCII art: 
set /p l5=^> 
set "l5=echo ^<escape^>[38;2;55;126;210m%l5%"
echo Please paste the sixth line of your ASCII art: 
set /p l6=^> 
set "l6=echo ^<escape^>[38;2;35;106;200m%l6%^<escape^>[0m"
call :scags

:scags
echo.
echo Commands for the gradient
echo (Replace ^<escape^> in each line with the escape character, which will be provided to you later in the script)
echo ------------------------------------------------------------------------------------------------------
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
goto start

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