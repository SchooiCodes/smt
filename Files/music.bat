@echo off
title Never Gonna Give You Up Music
set "file=music.mp3"
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%file%"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs

:loop
tasklist /FI "WindowTitle eq Get rickrolled!" > "%TEMP%\running.txt"
for /f "tokens=* delims=" %%a in (%TEMP%\running.txt) do (
	set line=%%a
	if "%line%"=="INFO: No tasks are running which match the specified criteria." taskkill /f /im cscript.exe & exit
)
goto loop