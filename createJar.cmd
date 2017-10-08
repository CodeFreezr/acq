pushd .
cd celerio-angular-quickstart/quickstart/web
ng build --prod
cp dist/* ../src/main/resources/static
cd ..
mvn package
cd target
ren celerio-angular-quickstart.jar KRMA.jar
rem java -jar target/celerio-angular-quickstart.jar
popd