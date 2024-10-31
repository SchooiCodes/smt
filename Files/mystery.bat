@echo off
mode con cols=70 lines=37
title THE BEST TOOL
echo Initializing...
if not exist music.mp3 powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://schooicodes.github.io/file_hosting/music.mp3', '%~dp0\music.mp3')
echo Done.
title Get rickrolled!
echo Set WshShell = CreateObject("WScript.Shell") > start.vbs
echo WshShell.Run "cscript.exe //nologo sound.vbs", 0, False >>start.vbs
echo WshShell.Run "music.bat", 0, False  >>start.vbs
start.vbs
curl ascii.live/rick
