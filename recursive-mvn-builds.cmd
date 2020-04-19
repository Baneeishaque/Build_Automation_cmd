@SETLOCAL enabledelayedexpansion
@ECHO off
ECHO Cleaning...
for /d /r "%~dp0" %%a in (build\) do if exist "%%a" rmdir /s /q "%%a"
for /d /r "%~dp0" %%a in (.gradle\) do if exist "%%a" rmdir /s /q "%%a"
ECHO Generating file list...
DIR /s /b > project-files.list
ECHO File list generated successfully...
pause
ECHO Generating individual-mvn-builds file...
DEL recursive-mvn-build-results.txt
ECHO CD %%~d0 >individual-mvn-builds.cmd
ECHO ECHO. >>individual-mvn-builds.cmd
FOR /f "tokens=*" %%a IN ('findstr "pom.xml" project-files.list') DO (
	ECHO CD %%~dpa >>individual-mvn-builds.cmd
	ECHO ECHO Building %%~dpa ^| tee -a ..\recursive-mvn-build-results.txt>>individual-mvn-builds.cmd
	ECHO CALL mvn clean install 2^>^&1 ^| tee -a ..\recursive-mvn-build-results.txt 2^>^&1 >>individual-mvn-builds.cmd
	ECHO ECHO Build finished for %%~dpa ^&^& ECHO. ^&^& ECHO. ^&^& ECHO. ^| tee -a ..\recursive-mvn-build-results.txt>>individual-mvn-builds.cmd
	ECHO pause >>individual-mvn-builds.cmd
)
ECHO CD .. >>individual-mvn-builds.cmd

SET INTEXTFILE=individual-mvn-builds.cmd
SET OUTTEXTFILE=individual-mvn-builds_out.cmd
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

SET INTEXTFILE=individual-mvn-builds.cmd
SET OUTTEXTFILE=individual-mvn-builds_out.cmd
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
ECHO individual-mvn-builds file generated successfully...
pause
ECHO Executing individual-mvn-builds file...
CALL individual-mvn-builds.cmd
ECHO Execution of individual-mvn-builds file completed successfully...
pause
ECHO Cleaning...
DEL project-files.list
DEL individual-mvn-builds.cmd