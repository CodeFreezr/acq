echo off

set h2-jar=D:\dbt\03\H2\bin\h2-1.4.193.jar
set krma-db-url=C:\dbt\acq\celerio-angular-quickstart\quickstart\target\db\angulardb
set krma-restore-file=..\sql\backup\%1.zip

echo ********************************************************************************
echo KRMA Restore
echo h2-jar:           %h2-jar%
echo krma-db-url:      %krma-db-url%
echo krma-restore-file: %krma-restore-file%
echo ********************************************************************************

java -cp %h2-jar% org.h2.tools.RunScript -url jdbc:h2:%krma-db-url% -user root -password manager -script %krma-restore-file% -options compression zip
echo on