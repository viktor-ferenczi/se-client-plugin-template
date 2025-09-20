@echo off
setlocal enabledelayedexpansion

REM Check if the required parameters are passed
REM (3rd param will be blank if there are not enough)
if "%~3" == "" (
    echo ERROR: Missing required parameters
    exit /b 1
)

REM Extract parameters and remove quotes
set NAME=%~1
set SOURCE=%~2
set BIN64=%~3

REM Remove trailing backslash if applicable
if "%NAME:~-1%"=="\" set NAME=%NAME:~0,-1%
if "%SOURCE:~-1%"=="\" set SOURCE=%SOURCE:~0,-1%
if "%BIN64:~-1%"=="\" set BIN64=%BIN64:~0,-1%

REM Verify Pulsar deployment and Local plugin folder
set PLUGIN_DIR=%AppData%\Pulsar\Legacy\Local
if not exist "%PLUGIN_DIR%" (
    echo "Missing Local plugin folder: %PLUGIN_DIR%"  
    echo "Pulsar not installed?"
    exit /b 2
)

REM Copy the plugin into the plugin directory
echo Copying "%NAME%" to "%PLUGIN_DIR%\"

for /l %%i in (1, 1, 10) do (
    copy /y "%SOURCE%\%NAME%" "%PLUGIN_DIR%\"

    if !ERRORLEVEL! NEQ 0 (
        REM "timeout" requires input redirection which is not supported,
        REM so we use ping as a way to delay the script between retries.
        ping -n 2 127.0.0.1 >NUL 2>&1
    ) else (
        goto BREAK_LOOP
    )
)

REM This part will only be reached if the loop has been exhausted
REM Any success would skip to the BREAK_LOOP label below
echo ERROR: Could not copy "%NAME%".
exit /b 1

:BREAK_LOOP
exit /b 0
