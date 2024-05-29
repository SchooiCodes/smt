@echo off
title THE BEST TOOL
echo Initializing...
if not exist music.mp3 powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://schooicodes.github.io/file_hosting/music.mp3', '%~dp0\music.mp3')
echo Done.
title Get rickrolled!
start /MIN music.bat
curl ascii.live/rick
