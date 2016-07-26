@ECHO OFF
REM Execute the powershell script with the same name as this file
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dpn0.ps1'"
PAUSE
