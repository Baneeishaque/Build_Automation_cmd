@SETLOCAL enabledelayedexpansion
@ECHO off

SET choice=A
ECHO Automatic Mode>recursive-gradle-build-results.txt
SET /P choice=Interactive execution(press I) or automated exection(default - just press Enter) : 
IF "%choice%"=="I" (ECHO Interactive Mode | tee recursive-gradle-build-results.txt) ELSE ECHO Automatic Mode
::goto EOF

SET folder=%CD%
SET /P folder=Use Current Folder(default - just press Enter) or Enter Another : 
ECHO Project Folder : %folder% | tee -a recursive-gradle-build-results.txt
::goto EOF

ECHO Cleaning... | tee -a recursive-gradle-build-results.txt
taskkill /im java.exe >NUL 2>NUL && (
  ECHO Terminated Java Process | tee -a recursive-gradle-build-results.txt
) || (
  ECHO Good, no Java Process | tee -a recursive-gradle-build-results.txt
)
FOR /d /r "%~dp0" %%a IN (.gradle\) DO IF EXIST "%%a" RMDIR /s /q "%%a"
FOR /d /r "%~dp0" %%a IN (build\) DO IF EXIST "%%a" RMDIR /s /q "%%a"
::goto EOF

ECHO Generating file list... | tee -a recursive-gradle-build-results.txt
DIR %folder% /B /S > project-files.list
ECHO File list generated successfully... | tee -a recursive-gradle-build-results.txt
IF "%choice%"=="I" (PAUSE)
::goto EOF

ECHO Generating individual-gradle-builds file... | tee -a recursive-gradle-build-results.txt
DEL recursive-gradle-build-results.txt 2>NUL
ECHO CD %%~d0 1^>NUL >individual-gradle-builds.bat
ECHO ECHO. >>individual-gradle-builds.bat
FOR /f "tokens=*" %%a IN ('findstr "gradlew.bat" project-files.list') DO (
	ECHO CD %%~dpa >>individual-gradle-builds.bat
	ECHO ECHO Building %%~dpa ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.bat
	ECHO CALL gradle_upgrade.bat recursive-gradle-build ^| tee -a ..\recursive-gradle-build-results.txt >>individual-gradle-builds.bat
	ECHO CALL gradlew.bat installDebug --debug --profile 2^>^&1 ^| tee -a ..\recursive-gradle-build-results.txt >>individual-gradle-builds.bat
	ECHO ECHO Build finished for %%~dpa ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.bat
	ECHO ECHO. ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.bat
	ECHO ECHO. ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.bat
	ECHO ECHO. ^| tee -a ..\recursive-gradle-build-results.txt>>individual-gradle-builds.bat
	IF "%choice%"=="I" (ECHO pause >>individual-gradle-builds.bat)
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
IF "%choice%"=="I" (PAUSE)

:EXE
ECHO Executing individual-gradle-builds file...
pause
CALL individual-gradle-builds.bat
ECHO Execution of individual-gradle-builds file completed successfully...
IF "%choice%"=="I" (PAUSE)

GOTO EOF
ECHO Cleaning...
DEL individual-gradle-builds.bat
DEL project-files.list

:EOF