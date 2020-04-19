ECHO Generating file list... | tee -a go_automation-results.txt
DIR  /S /B *.go | FINDSTR /e .go  > go_project-files.list
ECHO File list generated successfully... | tee -a go_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a go_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE go_project-files.list') DO (
	ECHO Processing %%a | tee -a go_automation-results.txt
	CD %%~dpa
	go build %%a
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a go_automation-results.txt
REM DEL project-files.list