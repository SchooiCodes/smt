@echo off
if exist logo.bat call logo.bat & echo.
echo Generating needed file..
echo Dim message, sapi > speak.vbs
echo message=InputBox("What do you want me to say?","Speak to Me") >> speak.vbs
echo Set sapi=CreateObject("sapi.spvoice") >> speak.vbs
echo sapi.Speak message >> speak.vbs
start /WAIT speak.vbs
del speak.vbs
pause
exit