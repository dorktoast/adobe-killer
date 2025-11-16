:: Adobe Killer https://github.com/dorktoast/adobe-killer
:: by dorktoast

@echo off

:: Auto-elevation check
:: Check if running as admin. If not, relaunch as admin.
>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo Requesting administrative privileges for this session...
	powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\" %*' -Verb RunAs"
	exit /b
)
:: End Auto-elevation check

title Adobe Killer by DorkToast
echo(
echo([97m    \        ^|        ^|         [91m    ^|  / _)  ^|  ^|           [0m
echo([97m   _ \    _` ^|   _ \   _ \   -_) [91m   . ^<   ^|  ^|  ^|   -_)   _^|[0m
echo([97m _/  _\ \__,_^| \___/ _.__/ \___^|[91m   _^|\_\ _^| _^| _^| \___^| _^|  [0m
echo(
echo( Adobe Killer by Dorktoast - [96mhttps://github.com/dorktoast/adobe-killer[0m
echo(
echo( You are about to terminate all Adobe processes and services. Please close all Adobe programs before proceeding.
pause

setlocal enabledelayedexpansion

:: Try to download latest Adobe process list from GitHub
set "PROCESS_LIST_URL=https://raw.githubusercontent.com/dorktoast/adobe-killer/refs/heads/main/processes-list.txt"
set "PROCESS_LIST_FILE=%TEMP%\adobe-processes.txt"
set "USE_REMOTE_LIST=0"

echo(
echo( Attempting to download latest process list...
powershell -Command "try { Invoke-WebRequest -UseBasicParsing '%PROCESS_LIST_URL%' -OutFile '%PROCESS_LIST_FILE%' -ErrorAction Stop } catch { exit 1 }"
if exist "%PROCESS_LIST_FILE%" (
    echo( Successfully downloaded latest process list.
    set "USE_REMOTE_LIST=1"
) else (
    echo( Could not download process list. Using built-in list.
)

:: "Fun" Adobe Facts
set FACT_COUNT=40

set MAX_ITERATIONS=20
set ITERATION=0
set KILL_SUCCESS=0

:loop
set /a ITERATION+=1
echo Iteration !ITERATION!

if !ITERATION! GTR !MAX_ITERATIONS! (
    echo Reached maximum iteration limit of !MAX_ITERATIONS!.
	pause
    goto end
)

set KILL_SUCCESS=0

if "!USE_REMOTE_LIST!"=="1" (
    :: Use the downloaded list from remote target
    for /f "usebackq delims=" %%a in ("%PROCESS_LIST_FILE%") do (
        taskkill /IM %%a /F >nul 2>&1
        if !ERRORLEVEL! EQU 0 (
            echo Killed process: %%a
            set KILL_SUCCESS=1
        )
    )
) else (
    :: Use the built-in fallback list
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
)

call :ShowFunFact
echo([0m

if !KILL_SUCCESS! EQU 1 (
    echo [92mSome processes were terminated, checking again...[0m
    goto loop
) else (
    echo [92mNo Adobe processes found running. Adobe Killer will now terminate.[0m
	echo Thank you for using Adobe Killer - [91m"Murdering adobe, one adobe at a time"(TM^)[0m
    goto end
)

:ShowFunFact
set /a "INDEX=(%RANDOM% %% FACT_COUNT) + 1"

echo(
echo( [93m--- Adobe "Fun" Fact #!INDEX! ---[0m
if %INDEX%==1 echo([93mAdobe apps are famously heavy on RAM and CPU, which is why many users keep a "panic kill" script like this nearby.
if %INDEX%==2 echo([93mAdobe Acrobat and Creative Cloud Helper processes sometimes continue running even after the main program is closed.
if %INDEX%==3 echo([93mPhotoshop and Illustrator have higher RAM and VRAM requirements than many competing tools for similar workloads.
if %INDEX%==4 echo([93mAdobe Creative Cloud runs multiple background helpers for sync, updates, and licensing—even when you are not actively using an app.
if %INDEX%==5 echo([93mCreative Cloud licensing and sync services can consume CPU cycles even when idle.
if %INDEX%==7 echo([93mAdobe apps can generate large temporary files that impact performance on smaller SSDs.
if %INDEX%==8 echo([93mAdobe applications typically have longer cold-start times compared to lighter alternatives.
if %INDEX%==9 echo([93mSome Adobe background processes have been reported to prevent system sleep or hibernation.
if %INDEX%==10 echo([93mAdobe services may continue running after you close the main app window, so killing background processes is sometimes the only way to free resources immediately.
if %INDEX%==11 echo([93mAdobe discontinued perpetual licenses for most products, requiring recurring subscriptions.
if %INDEX%==12 echo([93mIf this script seems aggressive, that's partly because Adobe tools can spawn several helper processes per app session.
if %INDEX%==13 echo([93mAdobe charges cancellation fees up to 50 percent of the remaining annual subscription commitment.
if %INDEX%==14 echo([93mAdobe apps require periodic online activation checks to remain functional.
if %INDEX%==15 echo([93mSome Adobe apps refuse to launch if the Creative Cloud desktop app is malfunctioning.
if %INDEX%==16 echo([93mSome Adobe subscription plans obscure cancellation fees until checkout.
if %INDEX%==17 echo([93mAdobe removed older Creative Cloud versions from official downloads due to licensing changes.
if %INDEX%==18 echo([93mAdobe's license terms allow deactivation of older software versions that use retired licensing systems.
if %INDEX%==19 echo([93mAdobe applications collect usage analytics unless manually disabled.
if %INDEX%==20 echo([93mAdobe apps periodically send telemetry about feature usage and performance.
if %INDEX%==21 echo([93mAdobe products must regularly check in with licensing servers for validation.
if %INDEX%==22 echo([93mAdobe's privacy policy allows aggregation of user behavior for product development.
if %INDEX%==23 echo([93mSome enterprise networks block Adobe telemetry endpoints for compliance reasons.
if %INDEX%==24 echo([93mAdobe Acrobat Reader historically receives frequent security patches due to vulnerabilities.
if %INDEX%==25 echo([93mCreative Cloud updates may reinstall components users previously removed.
if %INDEX%==26 echo([93mAdobe Flash Player, now retired, had a long record of high-severity security issues.
if %INDEX%==27 echo([93mAdobe apps often require multi-gigabyte updates that interrupt workflow.
if %INDEX%==28 echo([93mAdobe Updater can run automatically without clear prompts unless settings are changed.
if %INDEX%==29 echo([93mCertain Adobe apps have UI lag on high-DPI displays unless specific settings are changed.
if %INDEX%==30 echo([93mCreative Cloud uninstallers can leave residual files and services behind.
if %INDEX%==31 echo([93mAdobe apps may lose unsaved changes when they crash despite autosave features.
if %INDEX%==32 echo([93mPremiere Pro has recurring GPU compatibility issues depending on driver versions.
if %INDEX%==33 echo([93mIllustrator and InDesign can slow down when large font libraries are installed.
if %INDEX%==34 echo([93mLightroom catalogs grow over time and can significantly affect startup performance.
if %INDEX%==35 echo([93mCreative Cloud installers bundle services unrelated to the specific app being installed.
if %INDEX%==36 echo([93mAdobe has been criticized for raising subscription prices with little notice.
if %INDEX%==37 echo([93mAdobe has acquired competitors and later retired some competing tools.
if %INDEX%==38 echo([93mAdobe previously attempted to charge users for cloud storage overages even if they did not directly use the storage.
if %INDEX%==39 echo([93mAdobe's licensing restricts activation to two devices at a time.
if %INDEX%==40 echo([93mAdobe has sunset products entirely, leaving users without official updates or alternatives.

goto :EOF

:end
echo Finished.
pause

REM Please support me and my other creative projects on Patreon: https://www.patreon.com/gibgames