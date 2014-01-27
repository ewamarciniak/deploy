#!/bin/bash

cd integrate

#unzip the package
tar -zxvf pre_integrate.tgz
cd NCIRL

#start mysql to add to db
sudo service mysql start

#opens SQL and adds in data to custdetails table
cat<<FINISH | mysql -uroot -ppassword
drop database if exists dbtest;
CREATE DATABASE dbtest;
GRANT ALL PRIVILEGES ON dbtest.* TO dbtestuser@localhost IDENTIFIED BY 'dbpassword';
use dbtest;
drop table if exists custdetails;
create table if not exists custdetails ( name VARCHAR(30) NOT NULL DEFAULT '', address VARCHAR(30) NOT NULL DEFAULT '');
insert into custdetails (name,address) values ('John Doe','21 Jump Street');
FINISH

#stop mysql after integrationb
sudo service mysql stop

cd ..

#tar NCIRL and move to test folder
tar -czvf pre_test.tgz NCIRL
mv pre_test.tgz -t /tmp/$SANDBOX/test

#clean integrate folder
rm -rf NCIRL
cd ..
echo .....
echo Integration stage is coplete. Moving to the test stage
echo .....
