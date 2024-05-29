@echo off
title URL Shortener by Schooi
call logo.bat
echo.
echo URL SHORTENER
echo ---------------------
set /p url= Enter the URL to shorten: 
echo Success!
curl https://tinyurl.com/api-create.php?url=%url%
pause >nul