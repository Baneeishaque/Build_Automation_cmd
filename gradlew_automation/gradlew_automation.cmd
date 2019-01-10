::ECHO %1
::ECHO %3
::ECHO %4
::GOTO end

ECHO Generating file list... | tee -a gradlew_automation-results.txt
DIR %1 /B /S | FINDSTR /E build.gradle > gradlew_project-files.list
ECHO File list generated successfully... | tee -a gradlew_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a gradlew_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE gradlew_project-files.list') DO (
    ECHO Processing %%a | tee -a gradlew_automation-results.txt
    CD %%~dpa
    REM gradle tasks
    gradlew check
    REM gradle build
    gradlew installDebug
    REM gradle runDebug
    REM gradle run
    REM gradle androidInstall
    REM gradle launchIOSDevice
    REM gradle clean
    REM gradle cleanBuildCache
    CD %3
    IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a gradlew_automation-results.txt
REM DEL project-files.list

:end