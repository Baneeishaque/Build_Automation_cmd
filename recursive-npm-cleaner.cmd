@SETLOCAL enabledelayedexpansion
@ECHO off
ECHO Cleaning...
for /d /r "%~dp0" %%a in (node_modules\) do if exist "%%a" rmdir /s /q "%%a"
for /d /r "%~dp0" %%a in (.gradle\) do if exist "%%a" rmdir /s /q "%%a"
for /d /r "%~dp0" %%a in (build\) do if exist "%%a" rmdir /s /q "%%a"
GOTO end
ECHO Generating file list...
DIR /s /b > project-files.list
ECHO File list generated successfully...
pause
ECHO Generating individual-gradle-builds file...
DEL recursive-gradle-build-results.txt
ECHO CD %%~d0 >individual-gradle-builds.cmd
ECHO ECHO. >>individual-gradle-builds.cmd
FOR /f "tokens=*" %%a IN ('findstr "gradlew.cmd" project-files.list') DO (
	ECHO CD %%~dpa >>individual-gradle-builds.cmd
	ECHO ECHO Building %%~dpa ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.cmd
	ECHO CALL gradlew.cmd build 2^>^&1 ^| tee -a ..\recursive-gradle-build-results.txt >>individual-gradle-builds.cmd
	ECHO ECHO Build finished for %%~dpa ^&^& ECHO. ^&^& ECHO. ^&^& ECHO. ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.cmd
	ECHO pause >>individual-gradle-builds.cmd
)
ECHO CD .. >>individual-gradle-builds.cmd

SET INTEXTFILE=individual-gradle-builds.cmd
SET OUTTEXTFILE=individual-gradle-builds_out.cmd
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

SET INTEXTFILE=individual-gradle-builds.cmd
SET OUTTEXTFILE=individual-gradle-builds_out.cmd
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
ECHO Individual-gradle-builds file generated successfully...
pause
ECHO Executing individual-gradle-builds file...
CALL individual-gradle-builds.cmd
ECHO Execution of individual-gradle-builds file completed successfully...
pause
ECHO Cleaning...
DEL individual-gradle-builds.cmd
DEL project-files.list

:end