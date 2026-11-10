@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "ROOT=%~dp0.."
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" (
  echo ERROR: Visual Studio installation locator not found.
  exit /b 2
)
set "VSROOT="
for /f "usebackq delims=" %%V in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set "VSROOT=%%V"
if not defined VSROOT (
  echo ERROR: Visual Studio C++ Build Tools missing.
  exit /b 2
)
if not exist "%ROOT%\.deps\tomlplusplus-src\include\toml++\toml.hpp" (
  echo ERROR: Run CMake configure first so toml++ is available.
  exit /b 2
)
call "%VSROOT%\VC\Auxiliary\Build\vcvars64.bat" >nul
if errorlevel 1 exit /b 2
set "TESTDIR=%TEMP%\ost-pattern-test-%RANDOM%-%RANDOM%"
mkdir "%TESTDIR%"
if errorlevel 1 exit /b 2
pushd "%TESTDIR%"
cl /nologo /std:c++20 /EHsc /I"%ROOT%\src" /I"%ROOT%\src\OSTPlatform" /I"%ROOT%\build\generated" /I"%ROOT%\.deps\tomlplusplus-src\include" "%ROOT%\tests\pattern_loader_recovery_integration_test.cpp" "%ROOT%\src\Utils\SteamMetadata\PatternLoader.cpp" "%ROOT%\src\OSTPlatform\Numbers.cpp" "%ROOT%\src\OSTPlatform\Encoding.cpp" /Fe:"%TESTDIR%\pattern_loader_test.exe"
if errorlevel 1 (
  set "RESULT=2"
) else (
  "%TESTDIR%\pattern_loader_test.exe"
  set "RESULT=!ERRORLEVEL!"
)
popd
rmdir /s /q "%TESTDIR%"
exit /b %RESULT%
