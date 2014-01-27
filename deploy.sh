#!/bin/bash

cd deploy
tar -zxvf pre_deploy.tgz
rm pre_deploy.tgz
cd NCIRL/Apache

#deploy html files to /var/www in Apache
cp -R www /var
echo Deployed www
echo .....

#deploy scripts to /usr/lib/cgi-bin in Apache folder
cp -R cgi-bin /usr/lib
echo Deployed cgi
echo .....

#change permissions on script
chmod +x /usr/lib/cgi-bin/*

cd ../../../..

#remove the Sandbox
rm -rf $SANDBOX
echo Removed the $SANDBOX
echo .....
echo Deployment stage is complete. 
echo ....
