ECHO Generating file list... | tee -a cordova_automation-results.txt
DIR %1 /B /S | FINDSTR /E config.xml > cordova_project-files.list
ECHO File list generated successfully... | tee -a cordova_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a cordova_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE cordova_project-files.list') DO (
	ECHO Processing %%a | tee -a cordova_automation-results.txt
	CD %%~dpa
	cordova platform add android
	cordova build android
	cordova platform add ios
	cordova build ios
	cordova platform add blackberyy10
	cordova build blackberyy10
	cordova platform add ubuntu
	cordova build ubuntu
	cordova platform add wp8
	cordova build wp8
	cordova platform add windows
	cordova build windows
	cordova platform add osx
	cordova build osx
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a cordova_automation-results.txt
REM DEL project-files.list