@echo off
title THE BEST TOOL
echo Initializing...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://ve39.aadika.xyz/download/dQw4w9WgXcQ/mp3/128/1716747347/6b87bb06ad4e0cb061afe6c3841b1b51504a6e21d57ded96e42eaac8ec5c8bec/1', '%~dp0\music.mp3')
echo Done.
title Get rickrolled!
start /MIN music.bat
curl ascii.live/rick
