@echo off
setlocal

set "MACLIST=.\mac_list.txt"
set "SCRIPT=.\wol.ps1"
set "BROADCAST=255.255.255.255"
set "PORT=9"

call check_no_run_dates.bat
if errorlevel 2 (
    echo Error occurred while checking date.
    pause
) else if errorlevel 1 (
    echo No match for no-run date. Waking servers...
    powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%" -MacListPath "%MACLIST%" -BroadcastAddress "%BROADCAST%" -Port %PORT%
) else (
    echo No-run date matched. Skipping further actions.
    exit /b
)
endlocal
exit