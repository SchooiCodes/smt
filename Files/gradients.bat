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
echo [1] [38;5;214mOrange[97m --^> [38;5;219mPink[97m, [2] [38;5;40mGreen[97m --^> [38;5;45mBright Blue[97m, [3] [38;5;33mBlue[97m --^> [38;5;213mPink[97m
set /p choice=^> 
if %choice%==1 goto otp
if %choice%==2 goto gtbb
if %choice%==3 goto dbtp
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
echo.
echo Commands for the gradient
echo (Replace ^<escape^> in each line with the escape character, which will be provided to you)
echo ------------------------------------------------------------------------------------------------------
echo chcp 65001 >nul
echo %l1%
echo %l2%
echo %l3%
echo %l4%
echo %l5%
echo %l6%
echo chcp 437 >nul
echo ------------------------------------------------------------------------------------------------------
echo.
echo Would you like to copy the escape character? [y]/[N]
set /p copyesc=^> 
if /i "%copyesc%"=="y" @Set /P "="<NUL|Clip
goto start

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
echo.
echo Commands for the gradient
echo (Replace ^<escape^> in each line with the escape character, which will be provided to you)
echo ------------------------------------------------------------------------------------------------------
echo chcp 65001 >nul
echo %l1%
echo %l2%
echo %l3%
echo %l4%
echo %l5%
echo %l6%
echo chcp 437 >nul
echo ------------------------------------------------------------------------------------------------------
echo.
echo Would you like to copy the escape character? [y]/[N]
set /p copyesc=^> 
if /i "%copyesc%"=="y" @Set /P "="<NUL|Clip
goto start

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
echo.
echo Commands for the gradient
echo (Replace ^<escape^> in each line with the escape character, which will be provided to you)
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