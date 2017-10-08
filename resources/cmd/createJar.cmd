pushd .
cd ../../celerio-angular-quickstart/quickstart/web
call ng build --prod
cp dist/* ../src/main/resources/static
cd ..
call mvn package
cd target
ren celerio-angular-quickstart.jar KRMA.jar
popd