@echo off
setlocal enabledelayedexpansion

:: === Path to the local file you want to read ===
set "LOCAL_FILE=.\no_run_dates.txt"

:: Get today's date in YYYY/MM/DD format
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set "today=%datetime:~0,4%/%datetime:~4,2%/%datetime:~6,2%"

:: Check if the file exists
if not exist "%LOCAL_FILE%" (
    echo Local file not found: %LOCAL_FILE%
    exit /b 2
)

:: Read file line by line
set "matchFound=false"
for /f "usebackq delims=" %%D in ("%LOCAL_FILE%") do (
    set "line=%%D"
    if "!line!"=="%today%" (
        echo No-run date match found: !line!
        set "matchFound=true"
    )
)

:: Exit codes
if "!matchFound!"=="true" (
    exit /b 0
) else (
    echo No matching date found for %today%.
    exit /b 1
)

endlocal