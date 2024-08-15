@echo on
title URL Shortener by Schooi
call logo.bat
echo.
echo URL SHORTENER
echo ---------------------
set /p url= Enter the URL to shorten: 
echo %url% | findstr "https://" >nul
if ERRORLEVEL 1 set url=https://%url%
curl https://tinyurl.com/api-create.php?url=%url%
if ERRORLEVEL 0 echo Success!
pause >nul
exit