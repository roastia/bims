@echo off
cd /d "%~dp0"
set PORT=8765

echo ============================================
echo  Bookstore Inventory System - Starting Up
echo ============================================

where python >nul 2>nul
if errorlevel 1 (
  echo.
  echo [ERROR] Python was not found on this computer.
  echo Please install Python 3 from https://www.python.org/
  echo Be sure to check "Add Python to PATH" during setup.
  echo.
  pause
  exit /b 1
)

set PYVER=
for /f "delims=" %%v in ('python --version 2^>^&1') do set PYVER=%%v
echo %PYVER% | findstr /R "Python 3\." >nul
if errorlevel 1 (
  echo.
  echo [ERROR] The "python" command on this PC is not a real Python installation.
  echo It looks like the Microsoft Store app alias for Python is active instead.
  echo.
  echo To fix this:
  echo   1. Open Windows Settings, then go to:
  echo      Apps - Advanced app settings - App execution aliases
  echo   2. Turn OFF the switches for "python.exe" and "python3.exe"
  echo   3. Install real Python from https://www.python.org/downloads/
  echo      (check "Add Python to PATH" during setup)
  echo   4. Close this window, reopen it, and run start_windows.bat again
  echo.
  pause
  exit /b 1
)

echo Starting a local server on http://localhost:%PORT%
echo (This only serves files on this PC. Nothing goes over the internet.)
echo A separate minimized window titled "Bookstore Server" will keep running the
echo server. Close that window when you are done using the app.
echo.

start "Bookstore Server" /min cmd /c python -m http.server %PORT% --bind 127.0.0.1

ping -n 4 127.0.0.1 >nul

start http://127.0.0.1:%PORT%/index.html

echo The app should now be open in your browser.
echo If it did not open, go to http://127.0.0.1:%PORT%/index.html manually.
echo.
pause
