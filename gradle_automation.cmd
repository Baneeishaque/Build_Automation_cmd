::ECHO %1
::ECHO %3
::ECHO %4
::GOTO end

ECHO Generating file list... | tee -a gradle_automation-results.txt
DIR %1 /B /S | FINDSTR /E build.gradle > gradle_project-files.list
ECHO File list generated successfully... | tee -a gradle_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a gradle_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE gradle_project-files.list') DO (
	ECHO Processing %%a | tee -a gradle_automation-results.txt
	CD %%~dpa
	REM gradle tasks
	gradle check
	REM gradle build
	gradle installDebug
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
ECHO Cleaning... | tee -a gradle_automation-results.txt
REM DEL project-files.list

:end