@ECHO OFF
SET choice=A
ECHO Automatic Mode>build_automation-results.txt
SET /P choice=Interactive execution(press I) or automated exection(default - just press Enter) : 
::ECHO %choice%
IF "%choice%"=="I" (ECHO Interactive Mode | tee build_automation-results.txt) ELSE ECHO Automatic Mode
::GOTO end
::ECHO %CD%
::GOTO end
SET folder=%CD%
SET current_folder=%CD%
SET /P folder=Use Current Folder(default - just press Enter) or Enter Another : 
ECHO Lab Folder : %folder% | tee -a build_automation-results.txt
::GOTO end
::SET folder=D:\DK-HP-PA-2000AR\Projects\Apk_Decompiler

REM CALL gradle_automation %folder% %choice% %current_folder%
::GOTO end

CALL gradlew_automation %folder% %choice% %current_folder%

CALL bower_automation %folder% %choice% %current_folder%

CALL maven_automation %folder% %choice% %current_folder%

CALL ruby_automation %folder% %choice% %current_folder%

CALL rake_automation %folder% %choice% %current_folder%

CALL pip_automation %folder% %choice% %current_folder%

CALL composer_automation %folder% %choice% %current_folder%

CALL cordova_automation %folder% %choice% %current_folder%

CALL npm_yarn_react_automation %folder% %choice% %current_folder%

:end