@echo off
title Batch file creator by Schooi
echo Batch file creator
echo ============
echo Please enter the file's name (without extension)
set /p title=^> 
echo Placeholder text >> "%title%.bat"
notepad "%title%.bat"