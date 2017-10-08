@echo off
pushd .
cd ../../celerio-angular-quickstart/quickstart
call ng new web
rm web/src/app/app.module.ts web/src/app/app.component.* web/src/styles.css
cd web
call npm install --save @angular/material@2.0.0-beta.8 @angular/cdk@2.0.0-beta.8
call npm install --save @angular/animations
call npm install --save primeng@4.1.1
call npm install --save font-awesome
echo **********************************************************************************************
echo Do Backup
popd