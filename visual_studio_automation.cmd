ECHO Generating file list... | tee -a visual_studio_automation-results.txt
DIR  /S /B *.sln | FINDSTR /e .sln  > visual_studio_project-files.list
ECHO File list generated successfully... | tee -a visual_studio_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a visual_studio_automation-results.txt
CALL "%VS100COMNTOOLS%\vsvars32.bat"
FOR /F "TOKENS=*" %%a IN ('TYPE visual_studio_project-files.list') DO (
	ECHO Processing %%a | tee -a visual_studio_automation-results.txt
	CD %%~dpa
	devenv "%%a" /build "Debug"
	devenv "%%a" /build "Release"
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a visual_studio_automation-results.txt
REM DEL project-files.list