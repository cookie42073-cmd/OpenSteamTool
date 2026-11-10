@echo off
setlocal EnableExtensions
cd /d "%~dp0"
echo ====================================================
echo OpenSteamTool: Beginner Windows source-build setup
echo ====================================================
echo This checks/install build tools only. It never installs into Steam.
echo Each missing tool requires your permission before installation.
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup-build-tools.ps1" %*
set "RESULT=%ERRORLEVEL%"
echo.
if "%RESULT%"=="0" (echo Setup command completed.) else (echo Setup needs attention. Exit code %RESULT%.)
if /I not "%~1"=="-CheckOnly" pause
exit /b %RESULT%
