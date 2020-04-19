@SETLOCAL enabledelayedexpansion
@ECHO off
ECHO Cleaning...
ECHO Generating file list...
DIR /s /b > project-files.list
ECHO File list generated successfully...
pause
ECHO Generating individual-bundle-builds file...
DEL recursive-bundle-build-results.txt
ECHO CD %%~d0 >individual-bundle-builds.cmd
ECHO ECHO. >>individual-bundle-builds.cmd
FOR /f "tokens=*" %%a IN ('findstr "Gemfile" project-files.list') DO (
	ECHO CD %%~dpa >>individual-bundle-builds.cmd
	ECHO ECHO Building %%~dpa ^| tee -a ..\recursive-bundle-build-results.txt>>individual-bundle-builds.cmd
	ECHO CALL bundle install 2^>^&1 ^| tee -a ..\recursive-bundle-build-results.txt 2^>^&1 >>individual-bundle-builds.cmd
	ECHO ECHO Build finished for %%~dpa ^&^& ECHO. ^&^& ECHO. ^&^& ECHO. ^| tee -a ..\recursive-bundle-build-results.txt>>individual-bundle-builds.cmd
	ECHO pause >>individual-bundle-builds.cmd
)
ECHO CD .. >>individual-bundle-builds.cmd

SET INTEXTFILE=individual-bundle-builds.cmd
SET OUTTEXTFILE=individual-bundle-builds_out.cmd
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

SET INTEXTFILE=individual-bundle-builds.cmd
SET OUTTEXTFILE=individual-bundle-builds_out.cmd
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
ECHO Individual-bundle-builds file generated successfully...
pause
ECHO Executing individual-bundle-builds file...
CALL individual-bundle-builds.cmd
ECHO Execution of individual-bundle-builds file completed successfully...
pause
ECHO Cleaning...
DEL project-files.list
DEL individual-bundle-builds.cmd