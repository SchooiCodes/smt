@echo off
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irm -useb https://christitus.com/win | iex"
exit