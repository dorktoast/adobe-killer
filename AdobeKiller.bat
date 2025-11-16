: Adobe has a tendency to leave a lot of processes running for no reason. Run this BAT file and it will take care of them.
: Best to run as Administrator, because Adobe runs some of its processes as administrator.
: This BAT is updated regularly, because Adobe regularly changes its process names.

echo off
title Adobe Killer
echo You are about to terminate all Adobe processes and services. Please close all Adobe programs before proceeding.
pause

setlocal enabledelayedexpansion

set MAX_ITERATIONS=20
set ITERATION=0
set KILL_SUCCESS=0

:loop
set /a ITERATION+=1
echo Iteration !ITERATION!

if !ITERATION! GTR !MAX_ITERATIONS! (
    echo Reached maximum iteration limit of !MAX_ITERATIONS!.
    goto end
)

set KILL_SUCCESS=0

for %%a in (
    "AdobeUpdateService.exe"
    "Adobe Installer.exe"
    "Adobe Desktop Service.exe"
    "AdobeNotificationClient.exe"
    "AcrobatNotificationClient.exe"
    "Adobe CEF Helper.exe"
    "Adobe Crash Processor.exe"
    "Creative Cloud UI Helper.exe"
    "Creative Cloud Helper.exe"
    AdobeIPCBroker.exe
    CCLibrary.exe
    armsvc.exe
    AGMService.exe
    AdobeCollabSync.exe
    CCXProcess.exe
    CoreSync.exe
    "Adobe Crash Processor.exe"
) do (
    taskkill /IM %%a /F >nul 2>&1
    if !ERRORLEVEL! EQU 0 (
        echo Killed process: %%a
        set KILL_SUCCESS=1
    )
)

echo Completed iteration !ITERATION!

if !KILL_SUCCESS! EQU 1 (
    echo Some processes were terminated, checking again...
    goto loop
) else (
    echo No Adobe processes found running.
)

:end
echo Finished.
pause

REM Please support me and my other creative projects on Patreon: https://www.patreon.com/gibgames