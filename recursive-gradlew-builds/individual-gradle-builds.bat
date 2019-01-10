CD %~d0 1>NUL 
ECHO. 
CD D:\DK-HP-PA-2000AR\Laboratory\VS_Code_Batch\Automted_Builds\recursive-gradlew-builds\Blank Dark Sample\ 
ECHO Building D:\DK-HP-PA-2000AR\Laboratory\VS_Code_Batch\Automted_Builds\recursive-gradlew-builds\Blank Dark Sample\ | tee -a ..\recursive-gradle-build-results.txt
CALL gradle_upgrade.bat recursive-gradle-build | tee -a ..\recursive-gradle-build-results.txt 
CALL gradlew.bat installDebug --debug --profile 2>&1 | tee -a ..\recursive-gradle-build-results.txt 
ECHO Build finished for D:\DK-HP-PA-2000AR\Laboratory\VS_Code_Batch\Automted_Builds\recursive-gradlew-builds\Blank Dark Sample\ | tee -a ..\recursive-gradle-build-results.txt
ECHO. | tee -a ..\recursive-gradle-build-results.txt
ECHO. | tee -a ..\recursive-gradle-build-results.txt
ECHO. | tee -a ..\recursive-gradle-build-results.txt
CD .. 
