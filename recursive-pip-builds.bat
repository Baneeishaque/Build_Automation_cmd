@SETLOCAL enabledelayedexpansion
@ECHO off
ECHO Cleaning...
for /d /r "%~dp0" %%a in (node_modules\) do if exist "%%a" rmdir /s /q "%%a"
::for /d /r "%~dp0" %%a in (build\) do if exist "%%a" rmdir /s /q "%%a"
ECHO Generating file list...
DIR /s /b > project-files.list
ECHO File list generated successfully...
pause
ECHO Generating individual-pip-builds file...
DEL recursive-pip-build-results.txt
ECHO CD %%~d0 >individual-pip-builds.bat
ECHO ECHO. >>individual-pip-builds.bat
FOR /f "tokens=*" %%a IN ('findstr "requirements.txt" project-files.list') DO (
	ECHO CD %%~dpa >>individual-pip-builds.bat
	ECHO ECHO Building %%~dpa ^| tee -a ..\recursive-pip-build-results.txt>>individual-pip-builds.bat
	ECHO CALL pip install -r requirements.txt 2^>^&1 ^| tee -a ..\recursive-pip-build-results.txt >>individual-pip-builds.bat
	ECHO ECHO Build finished for %%~dpa ^&^& ECHO. ^&^& ECHO. ^&^& ECHO. ^| tee -a ..\recursive-pip-build-results.txt>>individual-pip-builds.bat
	ECHO pause >>individual-pip-builds.bat
)
ECHO CD .. >>individual-pip-builds.bat

SET INTEXTFILE=individual-pip-builds.bat
SET OUTTEXTFILE=individual-pip-builds_out.bat
SET SEARCHTEXT=ECHO Building %~dp0
SET REPLACETEXT=ECHO Building 
SET OUTPUTLINE=

FOR /f "tokens=1,* delims=¶" %%A IN ( '"TYPE %INTEXTFILE%"') DO (
	SET string=%%A
	SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

	ECHO !modified! >> %OUTTEXTFILE%
)
DEL %INTEXTFILE%
RENAME %OUTTEXTFILE% %INTEXTFILE%

SET INTEXTFILE=individual-pip-builds.bat
SET OUTTEXTFILE=individual-pip-builds_out.bat
SET SEARCHTEXT=ECHO Build finished for %~dp0
SET REPLACETEXT=ECHO Build finished for 
SET OUTPUTLINE=

FOR /f "tokens=1,* delims=¶" %%A IN ( '"TYPE %INTEXTFILE%"') DO (
	SET string=%%A
	SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

	ECHO !modified! >> %OUTTEXTFILE%
)
DEL %INTEXTFILE%
RENAME %OUTTEXTFILE% %INTEXTFILE%
ECHO individual-pip-builds file generated successfully...
pause
ECHO Executing individual-pip-builds file...
CALL individual-pip-builds.bat
ECHO Execution of individual-pip-builds file completed successfully...
pause
ECHO Cleaning...
DEL individual-pip-builds.bat
DEL project-files.list