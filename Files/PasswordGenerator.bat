@echo off
:Start2
cls
goto Start
:Start
cls
title Password Generator
echo I will make you a new password. 
echo Please write the password down somewhere in case you forget it. 
echo ----------------------------------------------------------------
echo How many characters would you like it to be?
set passlength=
set /p passlength= Choice: 
echo Generate password? (Y/N)
echo Input your choice
set input=
set /p input= Choice: 
if %input%==y goto passgen if NOT goto Start2
if %input%==Y goto passgen if NOT goto Start2
:passgen
cls
@echo off
setlocal EnableDelayedExpansion
set charSets=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*!@#$%^&*!@#$%^&*!@#$%^&*!@#$%^&*!@#$%^&*
set count=0

set /a countRaw=4+(%random%)%%20

for /L %%c in (1,1,%countRaw%) do (call :MAKERANDOMSTRING)
goto ENDRANDOMSTRING;

:MAKERANDOMSTRING
set buffer=% %
set count=0
set /a lowValue=30+(%random%)%%40
set /a length=!passlength!

:Loop
set /a count+=1
set /a rand=%Random%%%69
set buffer=!buffer!!charSets:~%rand%,1!
if !count! leq !length! goto Loop
echo Your password is: "%buffer%"
echo Would you like to copy it to your keyboard? (Y/N)
set input=
set /p input= Choice: 
if %input%==Y goto copy
if %input%==y goto copy
if %input%==N goto choice
if %input%==n goto choice

:copy
@Set /P "=%buffer%"<NUL|Clip
goto choice

:choice
echo Now choose what you want to do. 
echo 1) Go back to the beginning
echo 2) Exit
set input=
set /p input= Choice: 
if %input%==1 goto Start if NOT goto Start
if %input%==2 goto EXIT if NOT goto Start

:EXIT
exit
