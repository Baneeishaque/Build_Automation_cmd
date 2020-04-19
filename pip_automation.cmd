ECHO Generating file list... | tee -a pip_automation-results.txt
DIR %1 /B /S | FINDSTR /E requirements.txt > pip_project-files.list
ECHO File list generated successfully... | tee -a pip_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a pip_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE pip_project-files.list') DO (
	ECHO Processing %%a | tee -a pip_automation-results.txt
	CD %%~dpa
	pip install -r requirements.txt
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a pip_automation-results.txt
REM DEL project-files.list