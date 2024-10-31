for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
if %WINDOWSVER% GEQ 10 for /f "tokens=2,*delims=:" %%i in ('chcp') do set /a oldcp=%%i
if %WINDOWSVER% GEQ 10 chcp 65001 >nul
if %WINDOWSVER% GEQ 10 echo/░██████╗░█████╗░██╗░░██╗░█████╗░░█████╗░██╗██╗░██████╗
if %WINDOWSVER% GEQ 10 echo/██╔════╝██╔══██╗██║░░██║██╔══██╗██╔══██╗██║╚█║██╔════╝
if %WINDOWSVER% GEQ 10 echo/╚█████╗░██║░░╚═╝███████║██║░░██║██║░░██║██║░╚╝╚█████╗░
if %WINDOWSVER% GEQ 10 echo/░╚═══██╗██║░░██╗██╔══██║██║░░██║██║░░██║██║░░░░╚═══██╗
if %WINDOWSVER% GEQ 10 echo/██████╔╝╚█████╔╝██║░░██║╚█████╔╝╚█████╔╝██║░░░██████╔╝
if %WINDOWSVER% GEQ 10 echo/╚═════╝░░╚════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░░░╚═════╝░
if %WINDOWSVER% GEQ 10 echo/
if %WINDOWSVER% GEQ 10 echo/███╗░░░███╗██╗░░░██╗██╗░░░░░████████╗██╗████████╗░█████╗░░█████╗░██╗░░░░░
if %WINDOWSVER% GEQ 10 echo/████╗░████║██║░░░██║██║░░░░░╚══██╔══╝██║╚══██╔══╝██╔══██╗██╔══██╗██║░░░░░
if %WINDOWSVER% GEQ 10 echo/██╔████╔██║██║░░░██║██║░░░░░░░░██║░░░██║░░░██║░░░██║░░██║██║░░██║██║░░░░░
if %WINDOWSVER% GEQ 10 echo/██║╚██╔╝██║██║░░░██║██║░░░░░░░░██║░░░██║░░░██║░░░██║░░██║██║░░██║██║░░░░░
if %WINDOWSVER% GEQ 10 echo/██║░╚═╝░██║╚██████╔╝███████╗░░░██║░░░██║░░░██║░░░╚█████╔╝╚█████╔╝███████╗
if %WINDOWSVER% GEQ 10 echo/╚═╝░░░░░╚═╝░╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░╚════╝░░╚════╝░╚══════╝
if %WINDOWSVER% GEQ 10 chcp %oldcp% >nul
if %WINDOWSVER% LEQ 6 echo  __      _                 _ _         
if %WINDOWSVER% LEQ 6 echo / _\ ___^| ^|__   ___   ___ (_^| )__      
if %WINDOWSVER% LEQ 6 echo \ \ / __^| '_ \ / _ \ / _ \^| ^|/ __^|     
if %WINDOWSVER% LEQ 6 echo _\ \ (__^| ^| ^| ^| (_) ^| (_) ^| ^|\__ \     
if %WINDOWSVER% LEQ 6 echo \__/\___^|_^| ^|_^|\___/ \___/^|_^|^|___/     
if %WINDOWSVER% LEQ 6 echo.                                    
if %WINDOWSVER% LEQ 6 echo               _ _   _ _              _ 
if %WINDOWSVER% LEQ 6 echo   /\/\  _   _^| ^| ^|_(_) ^|_ ___   ___ ^| ^|
if %WINDOWSVER% LEQ 6 echo  /    \^| ^| ^| ^| ^| __^| ^| __/ _ \ / _ \^| ^|
if %WINDOWSVER% LEQ 6 echo / /\/\ \ ^|_^| ^| ^| ^|_^| ^| ^|^| (_) ^| (_) ^| ^|
if %WINDOWSVER% LEQ 6 echo \/    \/\__,_^|_^|\__^|_^|\__\___/ \___/^|_^|
if %WINDOWSVER% LEQ 6 echo.                            
