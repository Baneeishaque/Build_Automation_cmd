ECHO Generating file list... | tee -a rake_automation-results.txt
DIR %1 /B /S | FINDSTR /E Rakefile > rake_project-files.list
ECHO File list generated successfully... | tee -a rake_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a rake_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE rake_project-files.list') DO (
	ECHO Processing %%a | tee -a rake_automation-results.txt
	CD %%~dpa
	rake
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a rake_automation-results.txt
REM DEL project-files.list