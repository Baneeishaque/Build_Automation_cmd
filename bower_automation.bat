ECHO Generating file list... | tee -a bower_automation-results.txt
DIR %1 /B /S | FINDSTR /E bower.json > bower_project-files.list
ECHO File list generated successfully... | tee -a bower_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a bower_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE bower_project-files.list') DO (
	ECHO Processing %%a | tee -a bower_automation-results.txt
	CD %%~dpa
	bower install
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a bower_automation-results.txt
REM DEL project-files.list