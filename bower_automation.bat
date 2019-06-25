SET script_path=%CD%
REM ECHO %script_path%
REM PAUSE
REM SETLOCAL
REM ECHO %%~dp0
REM PAUSE
ECHO Generating file list... | tee bower_automation-results.txt
CAT bower_automation-results.txt
ECHO.
REM PAUSE
REM DIR %1
REM PAUSE
REM DIR %1 /B
REM PAUSE
REM DIR %1 /B /S
REM PAUSE
REM DIR %1 /B /S /A:-D
REM PAUSE
REM DIR %1 /B /S /A:-D | FINDSTR /E bower.json
REM PAUSE
REM DIR %1 /B /S /A:-D | FINDSTR /E bower.json | FINDSTR /V "\node_modules\ \lib\ \vendors\ "
REM PAUSE
DIR %1 /B /S /A:-D | FINDSTR /E bower.json | FINDSTR /V "\node_modules\ \lib\ \vendors\ \bower_components\ " > bower_project-files.list
CAT bower_project-files.list
ECHO.
PAUSE
ECHO File list generated successfully... | tee -a bower_automation-results.txt
CAT bower_automation-results.txt
ECHO.
IF "%2"=="I" (PAUSE)
ECHO. | tee -a bower_automation-results.txt
CAT bower_automation-results.txt
ECHO.
REM PAUSE
FOR /F "TOKENS=*" %%a IN ('TYPE bower_project-files.list') DO (
	ECHO Processing %%a | tee -a bower_automation-results.txt
	CAT bower_automation-results.txt
	ECHO.
	REM PAUSE
	CD %%~dpa
	REM PAUSE
	bower install
	CD %script_path%
	REM PAUSE
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a bower_automation-results.txt
CAT bower_automation-results.txt
ECHO.
DEL bower_project-files.list
DIR
REM PAUSE
