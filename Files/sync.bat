@echo off
cd /d "%~dp0"
if exist logo.bat call logo.bat & echo.
echo Running sync..
cd ..
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; irm https://raw.githubusercontent.com/SchooiCodes/file_hosting/refs/heads/main/sync.ps1 -OutFile sync.ps1"
powershell ./sync.ps1 
del sync.ps1