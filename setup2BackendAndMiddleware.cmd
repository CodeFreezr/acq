@echo off
pushd .
cd celerio-angular-quickstart/quickstart
call mvn -Pdb,metadata,gen generate-sources
echo **********************************************************************************************
echo change port to 8181 in /quickstart/web/proxy.conf.json
echo change port to 8181 in /quickstart/src/main/resources/application.yml
popd