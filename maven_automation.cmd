ECHO Generating file list... | tee -a maven_automation-results.txt
DIR %1 /B /S | FINDSTR /E pom.xml > maven_project-files.list
ECHO File list generated successfully... | tee -a maven_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a maven_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE maven_project-files.list') DO (
	ECHO Processing %%a | tee -a maven_automation-results.txt
	CD %%~dpa
	mvn clean install
	mvn clean
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a maven_automation-results.txt
REM DEL project-files.list