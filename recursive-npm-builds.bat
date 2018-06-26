@SETLOCAL enabledelayedexpansion
@ECHO off
ECHO Cleaning...
for /d /r "%~dp0" %%a in (node_modules\) do if exist "%%a" rmdir /s /q "%%a"
ECHO Generating file list...
DIR /s /b > project-files.list
ECHO File list generated successfully...
pause
ECHO Generating individual-npm-builds file...
DEL recursive-npm-build-results.txt
ECHO CD %%~d0 >individual-npm-builds.bat
ECHO ECHO. >>individual-npm-builds.bat
FOR /f "tokens=*" %%a IN ('findstr "package.json" project-files.list') DO (
	ECHO CD %%~dpa >>individual-npm-builds.bat
	ECHO ECHO Building %%~dpa ^| tee -a ..\recursive-npm-build-results.txt>>individual-npm-builds.bat
	ECHO CALL npm install 2^>^&1 ^| tee -a ..\recursive-npm-build-results.txt >>individual-npm-builds.bat
	ECHO ECHO Build finished for %%~dpa ^&^& ECHO. ^&^& ECHO. ^&^& ECHO. ^| tee -a ..\recursive-npm-build-results.txt>>individual-npm-builds.bat
	ECHO pause >>individual-npm-builds.bat
)
ECHO CD .. >>individual-npm-builds.bat

SET INTEXTFILE=individual-npm-builds.bat
SET OUTTEXTFILE=individual-npm-builds_out.bat
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

SET INTEXTFILE=individual-npm-builds.bat
SET OUTTEXTFILE=individual-npm-builds_out.bat
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
ECHO individual-npm-builds file generated successfully...
pause
ECHO Executing individual-npm-builds file...
CALL individual-npm-builds.bat
ECHO Execution of individual-npm-builds file completed successfully...
pause
ECHO Cleaning...
DEL individual-npm-builds.bat
DEL project-files.list