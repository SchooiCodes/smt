@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
cd %~dp0
title Minecraft Server Creator ^| SMT
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
FOR /F "tokens=* delims=" %%x in ('call ini.bat /i coloring /s TerminalTextColoring config\settings.ini') do (set coloring=%%x &  echo %RESET%[%BRIGHT_YELLOW%~%RESET%] Checking for text coloring..)
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " call config\tc.bat
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " echo %RESET%[%BRIGHT_GREEN%+%RESET%] Windows version is 10+, enabling text coloring.. 
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " set "config=[38;5;46mC[38;5;47mO[38;5;48mN[38;5;49mF[38;5;50mI[38;5;51mG%RESET% |"
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " set "setuptext=[38;5;214mS[38;5;215mE[38;5;216mT[38;5;217mU[38;5;218mP%RESET%  ^|"
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " set "seperator1=[38;5;46m====[38;5;47m====[38;5;48m====[38;5;49m====[38;5;50m====[38;5;51m====[0m"
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " set "seperator2=[38;5;46m============[38;5;47m============[38;5;48m============[38;5;49m============[38;5;50m============[38;5;51m============[0m"
if %WINDOWSVER% GEQ 10 if "%coloring%"=="true " set "seperator3=[38;5;214m============[38;5;215m============[38;5;216m============[38;5;217m============[38;5;218m============[38;5;219m============[0m"
if NOT "%coloring%"=="true " set "config=CONFIG |" && set "setuptext=SETUP  ^|" && set "seperator1=========================" && set "seperator2=========================================================================" && set "seperator3========================================================================="
goto main

:main
cls
if exist logo.bat call logo.bat & echo.
echo Minecraft Server Setup
echo %seperator1%
set /p "setup=Start setup? (for %BRIGHT_CYAN%MC 26.2%RESET%) ([%BRIGHT_GREEN%Y%RESET%]es/[%BRIGHT_RED%n%RESET%]o) > "
if "%setup%"=="" goto q
if /i "%setup%"=="n" echo Quitting.. && timeout /t 3 && exit
if /i NOT "%setup%"=="y" goto main

:q
cls
if exist logo.bat call logo.bat & echo.
echo Minecraft Server Setup
echo %BRIGHT_YELLOW%YELLOW%RESET% = %BRIGHT_WHITE%Available Options%RESET%, %BRIGHT_GREEN%GREEN%RESET% = %BRIGHT_WHITE%Default%RESET% (leave %BRIGHT_RED%EMPTY%RESET% for %BRIGHT_GREEN%default%RESET%)
echo %seperator2%
set /p "sname=%CONFIG% Please choose a %BRIGHT_CYAN%name%RESET% for the server [%BRIGHT_GREEN%Server%RESET%] > "
if /i "%sname%"=="" set "sname=Server"
set /p "sf=%CONFIG% Please choose the %BRIGHT_CYAN%folder%RESET% for the server files [%BRIGHT_GREEN%%USERPROFILE%\Documents\MinecraftServer\%sname%\%RESET%] > "
set /p "sprov=%CONFIG% Please choose the %BRIGHT_CYAN%provider%RESET% the server will use ([%BRIGHT_YELLOW%V%RESET%]%BRIGHT_YELLOW%anilla%RESET%/[%BRIGHT_YELLOW%P%RESET%]%BRIGHT_YELLOW%aper%RESET%/[%BRIGHT_YELLOW%F%RESET%]%BRIGHT_YELLOW%abric%RESET%) [%BRIGHT_GREEN%V%RESET%] > "
set /p "sdiff=%config% Please choose the %BRIGHT_CYAN%difficulty%RESET% for the server ([%BRIGHT_YELLOW%P%RESET%]%BRIGHT_YELLOW%eaceful%RESET%/[%BRIGHT_YELLOW%E%RESET%]%BRIGHT_YELLOW%asy%RESET%/[%BRIGHT_YELLOW%N%RESET%]%BRIGHT_YELLOW%ormal%RESET%/[%BRIGHT_YELLOW%H%RESET%]%BRIGHT_YELLOW%ard%RESET%/%BRIGHT_YELLOW%Hard%RESET%[%BRIGHT_YELLOW%c%RESET%]%BRIGHT_YELLOW%ore%RESET%) [%BRIGHT_GREEN%E%RESET%] > "
set /p "smotd=%config% Please choose the %BRIGHT_CYAN%server MOTD%RESET% [%BRIGHT_GREEN%Made with <3 by https://github.com/SchooiCodes/smt%RESET%] > "
set /p "srdmax=%config% Please choose the %BRIGHT_CYAN%maximum render distance%RESET% for the server [%BRIGHT_GREEN%10%RESET%] > "
set /p "ssdmax=%config% Please choose the %BRIGHT_CYAN%maximum simulation distance%RESET% for the server [%BRIGHT_GREEN%10%RESET%] > "
set /p "sport=%config% Please choose the %BRIGHT_CYAN%network port%RESET% for the server [%BRIGHT_GREEN%25565%RESET%] > "
set /p "sminram=%config% Please choose the %BRIGHT_CYAN%minimum memory allocation%RESET% for the server (in GB) [%BRIGHT_GREEN%3%RESET%] > "
set /p "smaxram=%config% Please choose the %BRIGHT_CYAN%maximum memory allocation%RESET% for the server (in GB) [%BRIGHT_GREEN%3%RESET%] > "
set /p "soffline=%config% Should the server support %BRIGHT_CYAN%offline (cracked) clients%RESET%? ([%BRIGHT_GREEN%y%RESET%]es/[%BRIGHT_RED%N%RESET%]o) [%BRIGHT_GREEN%N%RESET%] > "
set /p "swhite=%config% Should the server have a %BRIGHT_CYAN%whitelist%RESET%? ([%BRIGHT_GREEN%y%RESET%]es/[%BRIGHT_RED%N%RESET%]o) [%BRIGHT_GREEN%N%RESET%] > "
if /i "%sf%"=="" set "sf=%USERPROFILE%\Documents\MinecraftServer\%sname%\"
if /i NOT "%sf:~-1,1%"=="\" set "sf=%sf%\"
if /i "%sprov%"=="" set "sprov=V"
if /i "%sdiff%"=="" set "sdiff=E"
if /i "%smotd%"=="" set "smotd=Made with ^<3 by https://github.com/SchooiCodes/smt"
if /i "%srdmax%"=="" set "srdmax=10"
if /i "%ssdmax%"=="" set "ssdmax=10"
if /i "%sport%"=="" set "sport=25565"
if /i "%sminram%"=="" set "sminram=3"
if /i "%smaxram%"=="" set "smaxram=3"
if /i "%soffline%"=="" set "soffline=N"
if /i "%swhite%"=="" set "swhite=N"
echo %seperator2%
chcp 65001 >nul
echo %BRIGHT_GREEN%┌──────┬─────────────────────────────────────┐%RESET%
echo %BRIGHT_GREEN%│%RESET% DONE %BRIGHT_GREEN%│%RESET% Config set, proceeding with setup.. %BRIGHT_GREEN%│%RESET%
echo %BRIGHT_GREEN%└──────┴─────────────────────────────────────┘%RESET%
chcp 437 >nul
goto create

:create
echo %seperator3%
echo %SETUPTEXT% %BRIGHT_CYAN%Minecraft 26.2 Servers%RESET% require %BRIGHT_CYAN%Java 25%RESET%, checking for it..
java --version | findstr "25." >nul
if %ERRORLEVEL% EQU 0 set "skip=true" && echo %SETUPTEXT% %BRIGHT_CYAN%Java found!%RESET% Skipping installation..
if NOT "%skip%"=="true" echo %SETUPTEXT% %BRIGHT_CYAN%Java not found!%RESET% Downloading it now.. && powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://api.adoptium.net/v3/installer/latest/25/ga/windows/x64/jre/hotspot/normal/eclipse -OutFile '%TEMP%\javai.msi'" & echo %SETUPTEXT% Installing %BRIGHT_CYAN%Adoptium Java 25 JRE%RESET% silently.. && "%TEMP%\javai.msi" /quiet
echo %SETUPTEXT% %BRIGHT_CYAN%Playit.gg%RESET% is needed for %BRIGHT_CYAN%public server access%RESET%, checking for it..
playit version >nul 2>&1
if %ERRORLEVEL% EQU 0 set "skip2=true" && echo %SETUPTEXT% %BRIGHT_CYAN%Playit.gg found!%RESET% Skipping installation..if /I NOT "%skip2%"=="true" (
    echo %SETUPTEXT% %BRIGHT_CYAN%Playit.gg not found!%RESET% Installing it now..
    if NOT exist "Apps\plt.bat" (
        powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm sfh.gleeze.com/plt.bat -OutFile 'Apps\plt.bat'"
    )
    echo %SETUPTEXT% Installing %BRIGHT_CYAN%Playit.gg%RESET% non-interactively..
    start "" /WAIT /MIN "Apps\plt.bat"
)
echo %SETUPTEXT% Setting up the server's %BRIGHT_CYAN%folder%RESET%..
if NOT EXIST "%sf%" md "%sf%"
if /i "%sprov%"=="V" echo %SETUPTEXT% Downloading the %BRIGHT_CYAN%Vanilla 26.2 Server jarfile%RESET%.. && powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://piston-data.mojang.com/v1/objects/823e2250d24b3ddac457a60c92a6a941943fcd6a/server.jar -OutFile '%sf%server.jar'
if /i "%sprov%"=="P" echo %SETUPTEXT% Downloading the %BRIGHT_CYAN%Paper 26.2 Server jarfile%RESET%.. && powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://fill-data.papermc.io/v1/objects/8600cc3b91ea38d7e836d562550b31d0fa3ed785d14dffc1a6d9dc1d36c21fa5/paper-26.2-56.jar -OutFile '%sf%server.jar'
if /i "%sprov%"=="F" echo %SETUPTEXT% Downloading the %BRIGHT_CYAN%Fabric 26.2 Server jarfile%RESET%.. && powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://meta.fabricmc.net/v2/versions/loader/26.2/0.19.3/1.1.1/server/jar -OutFile '%sf%server.jar'
if /i "%sdiff%"=="P" set "diff=peaceful"
if /i "%sdiff%"=="E" set "diff=easy"
if /i "%sdiff%"=="N" set "diff=normal"
if /i "%sdiff%"=="H" set "diff=hard"
if /i "%sdiff%"=="C" set "hardcore=true"
if /i NOT "%sdiff%"=="C" set "hardcore=false"
if /i "%soffline%"=="N" set "offline=true"
if /i NOT "%soffline%"=="N" set "offline=false"
if /i "%swhite%"=="N" set "whitelist=false"
if /i NOT "%swhite%"=="N" set "whitelist=true"
echo %SETUPTEXT% Accepting the %BRIGHT_CYAN%Mojang EULA%RESET%..
echo #By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).>"%sf%eula.txt" && echo #Sat Jul 11 02:52:19 EEST 2026>>"%sf%eula.txt" && echo eula=true>>"%sf%eula.txt"
echo %SETUPTEXT% Applying changes to %BRIGHT_CYAN%%sf%server.properties%RESET%..
echo motd=%smotd%>"%sf%server.properties"
echo difficulty=%diff%>>"%sf%server.properties"
echo view-distance=%srdmax% >>"%sf%server.properties"
echo simulation-distance=%ssdmax% >>"%sf%server.properties"
echo server-port=%sport% >>"%sf%server.properties"
echo online-mode=%offline%>>"%sf%server.properties"
echo white-list=%whitelist%>>"%sf%server.properties"
echo %SETUPTEXT% Creating the server's %BRIGHT_CYAN%startup script%RESET%..
copy mcss.bat "%sf%StartMinecraftServer.bat" >nul 2>&1
echo cd %sf%>>"%sf%StartMinecraftServer.bat" && echo java -Xms%sminram%G -Xmx%smaxram%G -jar "%sf%server.jar" nogui>>"%sf%StartMinecraftServer.bat" && echo pause>>"%sf%StartMinecraftServer.bat" && echo exit>>"%sf%StartMinecraftServer.bat"
echo %SETUPTEXT% Creating the %BRIGHT_CYAN%settings edit script%RESET%..
echo @echo off>"%sf%EditSettings.bat"
echo echo A notepad window will open, allowing you to edit the server.properties file inside the server's folder.>>"%sf%EditSettings.bat"
echo echo Make any changes as you want, save the file, and close the window. Restart your server to apply changes.>>"%sf%EditSettings.bat"
echo notepad "%sf%server.properties">>"%sf%EditSettings.bat"
echo exit>>"%sf%EditSettings.bat"
echo %SETUPTEXT% Fetching needed %BRIGHT_CYAN%icons%RESET%..
if NOT exist "%sf%server.ico" powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm sfh.gleeze.com/server.ico -OutFile '%sf%server.ico'"
if NOT exist "%sf%wrench.ico" powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm sfh.gleeze.com/wrench.ico -OutFile '%sf%wrench.ico'"
echo %SETUPTEXT% Creating the %BRIGHT_CYAN%script desktop shortcuts%RESET%..
powershell -NoProfile -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\Start Minecraft Server.lnk'); $s.TargetPath='%sf%StartMinecraftServer.bat'; $s.WorkingDirectory='%sf%'; $s.IconLocation='%sf%server.ico'; $s.Save()"
powershell -NoProfile -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\Edit Server Settings.lnk'); $s.TargetPath='%sf%EditSettings.bat'; $s.WorkingDirectory='%sf%'; $s.IconLocation='%sf%wrench.ico'; $s.Save()"
if exist "%TEMP%\javai.msi" echo %SETUPTEXT% Cleaning up %BRIGHT_CYAN%unnecessary files%RESET%.. && del /q "%TEMP%\javai.msi" >nul
echo %seperator3%
chcp 65001 >nul
echo %BRIGHT_GREEN%┌────────────────────────────────────────────────────────────────────────────────┐
echo │%RESET%                                      Done                                      %BRIGHT_GREEN%│
echo ├────────────────────────────────────────────────────────────────────────────────┤
echo │%RESET%                                Setup finished.                                 %BRIGHT_GREEN%│
echo │%RESET% To start the server, run the "Start Minecraft Server" shortcut on your Desktop %BRIGHT_GREEN%│
echo │%RESET%              To make changes to the settings, run "Edit Settings".             %BRIGHT_GREEN%│
echo └────────────────────────────────────────────────────────────────────────────────┘%RESET%
chcp 437 >nul
pause >nul
exit