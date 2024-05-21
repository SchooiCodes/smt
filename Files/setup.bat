@echo off
if /I "%CD:~0,1%"=="C" goto elevate

:start
title SMT ^| Setup
echo Disclaimer:
echo This Multitool (the "Schooi's Multitool") is provided for ethical purposes only. The creators and contributors of this tool do not condone, support, or endorse any illegal or unethical activities. The use of this tool for unauthorized access to computer systems, networks, or data is strictly prohibited and may violate local, national, and international laws.
echo By accessing, downloading, or using this tool, you agree to use it responsibly and lawfully. You acknowledge that any misuse of this tool, including but not limited to unauthorized access, data theft, or disruption of services, may result in legal consequences and civil liability.
echo The creators and contributors of this tool shall not be held responsible for any misuse or illegal activity conducted by users. Users are solely responsible for their actions and are encouraged to use this tool in accordance with ethical hacking principles and applicable laws.
echo This tool is provided "as is" without any warranty of any kind, express or implied. The creators and contributors make no representations or warranties regarding the accuracy, reliability, or suitability of the tool for any purpose.
echo By using this tool, you agree to indemnify and hold harmless the creators and contributors from any claims, damages, losses, liabilities, or expenses arising out of or in connection with your use of the tool.
echo Type "I AGREE" to continue.
set /p agree=^> 
if /I not "%agree%"=="I AGREE" exit:
if /I "%CD:~0,1%"=="C" goto C
goto USB

:elevate
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        >nul pause && exit 1
    )
    exit 0
)
goto start

:C
cd /d "C:\Program Files"
md "Schooi's Multitool" 2>nul
cd "Schooi's Multitool"
copy /y NUL needed_file.schm >NUL
attrib +h +s needed_file.schm
del "%~f0"
pause
exit

:USB
if NOT "%cd%"=="%CD:~0,3%" cd .. & goto USB
copy /y NUL needed_file.schm >NUL 
attrib +h +s needed_file.schm
del "%~f0"
exit
