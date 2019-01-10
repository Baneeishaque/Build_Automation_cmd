ECHO Generating file list... | tee -a npm_yarn_react_automation-results.txt
DIR %1 /B /S | FINDSTR /E package.json > npm_yarn_react_project-files.list
ECHO File list generated successfully... | tee -a npm_yarn_react_automation-results.txt
IF "%2"=="I" (PAUSE)
ECHO. | tee -a npm_yarn_react_automation-results.txt
FOR /F "TOKENS=*" %%a IN ('TYPE npm_yarn_react_project-files.list') DO (
	ECHO Processing %%a | tee -a npm_yarn_react_automation-results.txt
	CD %%~dpa
	npm install
	REM npm start
	npm test
	npm run ios
	npm run android
	yarn install
	REM yarn start
	yarn test
	yarn run ios
	yarn run android
	react-native run-android
	react-native run-ios
	CD %3
	IF "%2"=="I" (PAUSE)
)
ECHO.
ECHO Cleaning... | tee -a npm_yarn_react_automation-results.txt
REM DEL project-files.list