ECHO Generating file list... | tee -a cordova_automation-results.txt
DIR %1 /B /S | FINDSTR /E config.xml > cordova_project-files.list
ECHO File list generated successfully... | tee -a cordova_automation-results.txt
REM IF "%2"=="I" (PAUSE)
PAUSE
ECHO. | tee -a cordova_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE cordova_project-files.list') DO (
	ECHO Processing %%a | tee -a cordova_automation-results.txt
	CD %%~dpa
	cordova platform add android
	cordova build android
	REM cordova run android
	REM cordova platform add ios
	REM cordova build ios
	REM cordova run ios
	REM cordova platform add blackberyy10
	REM cordova build blackberyy10
	REM cordova run blackberyy10
	REM cordova platform add ubuntu
	REM cordova build ubuntu
	REM cordova run ubuntu
	REM cordova platform add wp8
	REM cordova build wp8
	REM cordova run wp8
	REM cordova platform add windows
	REM cordova build windows
	REM cordova run windows
	REM cordova platform add osx
	REM cordova build osx
	REM cordova run osx
	REM cordova platform add browser 
	REM cordova build browser 
	REM cordova run browser 
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a cordova_automation-results.txt
REM DEL project-files.list