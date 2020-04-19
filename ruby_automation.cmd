ECHO Generating file list... | tee -a ruby_automation-results.txt
DIR %1 /B /S | FINDSTR /E Gemfile > ruby_project-files.list
ECHO File list generated successfully... | tee -a ruby_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a ruby_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE ruby_project-files.list') DO (
	ECHO Processing %%a | tee -a ruby_automation-results.txt
	CD %%~dpa
	bundle install
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a ruby_automation-results.txt
REM DEL project-files.list