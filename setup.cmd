@echo off
pushd .
copy resources\sql\01-create.sql celerio-angular-quickstart\quickstart-conf\01-create.sql
copy resources\sql\celerio-maven-plugin.xml celerio-angular-quickstart\quickstart-conf\celerio-maven-plugin.xml
xcopy resources\tmpl celerio-angular-quickstart\pack-angular /S /Y /D
cd celerio-angular-quickstart\quickstart
call mvn -Pdb,metadata,gen generate-sources
echo **********************************************************************************************
popd