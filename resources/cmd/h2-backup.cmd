echo off

call groovy tstamp > tmpfile
set /p datetimestamp= < tmpFile 
del tmpFile

set h2-jar=D:\dbt\03\H2\bin\h2-1.4.193.jar
set krma-db-url=C:\dbt\acq\celerio-angular-quickstart\quickstart\target\db\angulardb
set krma-backup-file=..\sql\backup\krma-%datetimestamp%.zip

echo ********************************************************************************
echo KRMA Bakup
echo h2-jar:           %h2-jar%
echo krma-db-url:      %krma-db-url%
echo krma-backup-file: %krma-backup-file%
echo ********************************************************************************

java -cp %h2-jar% org.h2.tools.Script -url jdbc:h2:%krma-db-url% -user root -password manager -script %krma-backup-file% -options compression zip
echo on