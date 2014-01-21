#!/bin/bash

cd build

git clone https://github.com/FSlyne/NCIRL.git

#tar NCIRL and move to integrate folder

tar -czvf pre_integrate.tgz NCIRL

#check if the MD5sum has changed 
MD5SUM=$(md5sum pre_integrate.tgz | cut -f 1 -d' ')
PREVMD5SUM=$(cat /tmp/md5sum)
FILECHANGE=0
echo .....
echo Checking if the new webpackage is different to the one on the live platform
echo .....
if [[ "$MD5SUM" != "$PREVMD5SUM" ]]
then
        FILECHANGE=1
        echo $MD5SUM Not equal to $PREVMD5SUM. Continuing the deployment process.
else
        FILECHANGE=0
        echo $MD5SUM Equal to $PREVMD5SUM. Exiting the deployment process.
fi
echo .....
echo $MD5SUM > /tmp/md5sum
if [ $FILECHANGE -eq 0 ]
then
        echo no change in files, doing nothing and exiting
        exit
fi

mv pre_integrate.tgz -t /tmp/$SANDBOX/integrate

#clean build folder

rm -rf NCIRL

cd ..
