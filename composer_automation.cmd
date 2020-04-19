ECHO Generating file list... | tee -a composer_automation-results.txt
DIR %1 /B /S | FINDSTR /E composer.json > composer_project-files.list
ECHO File list generated successfully... | tee -a composer_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a composer_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE composer_project-files.list') DO (
	ECHO Processing %%a | tee -a composer_automation-results.txt
	CD %%~dpa
	composer install
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a composer_automation-results.txt
REM DEL project-files.list