echo off
set h2-jar=D:\dbt\03\H2\bin\h2-1.4.196.jar
set krma-db-url=D:\dbt\acq\celerio-angular-quickstart\quickstart\target\db\angulardb
rem java org.h2.tools.Script -url jdbc:h2:~/test -user sa -script test.zip -options compression zip
rem jdbc:h2:D:\dbt\acq\celerio-angular-quickstart\quickstart\target\db\angulardb;MVCC=TRUE;FILE_LOCK=NO
echo *****
echo h2-jar:      %h2-jar%
echo krma-db-url: %krma-db-url%
echo *****
java -cp %h2-jar% org.h2.tools.Script -url jdbc:h2:%krma-db-url% -user root -password manager -script krma-db-backup.zip -options compression zip
echo on