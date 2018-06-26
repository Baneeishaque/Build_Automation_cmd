@SETLOCAL enabledelayedexpansion
@ECHO off
ECHO Cleaning...
for /d /r "D:\DK-HP-PA-2000AR\Laboratory\Android_Studio" %%a in (.gradle\) do if exist "%%a" rmdir /s /q "%%a"
for /d /r "D:\DK-HP-PA-2000AR\Laboratory\Android_Studio" %%a in (build\) do if exist "%%a" rmdir /s /q "%%a"
GOTO end
ECHO Generating file list...
DIR /s /b > project-files.list
ECHO File list generated successfully...
pause
ECHO Generating individual-gradle-builds file...
DEL recursive-gradle-build-results.txt
ECHO CD %%~d0 >individual-gradle-builds.bat
ECHO ECHO. >>individual-gradle-builds.bat
FOR /f "tokens=*" %%a IN ('findstr "gradlew.bat" project-files.list') DO (
	ECHO CD %%~dpa >>individual-gradle-builds.bat
	ECHO ECHO Building %%~dpa ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.bat
	ECHO CALL gradlew.bat build 2^>^&1 ^| tee -a ..\recursive-gradle-build-results.txt >>individual-gradle-builds.bat
	ECHO ECHO Build finished for %%~dpa ^&^& ECHO. ^&^& ECHO. ^&^& ECHO. ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.bat
	ECHO pause >>individual-gradle-builds.bat
)
ECHO CD .. >>individual-gradle-builds.bat

SET INTEXTFILE=individual-gradle-builds.bat
SET OUTTEXTFILE=individual-gradle-builds_out.bat
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

SET INTEXTFILE=individual-gradle-builds.bat
SET OUTTEXTFILE=individual-gradle-builds_out.bat
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
CALL individual-gradle-builds.bat
ECHO Execution of individual-gradle-builds file completed successfully...
pause
ECHO Cleaning...
DEL individual-gradle-builds.bat
DEL project-files.list

:end