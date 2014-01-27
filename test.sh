#!/bin/bash

cd test
tar -zxvf pre_test.tgz
rm pre_test.tgz
cd NCIRL

#check the HTML, fix the errors and save them in the errors.txt file in the sandbox folder 
echo Checking HTML
echo .....
#find ./Apache/www -type f -name "*.html" -exec tidy -f .\..\..\errors.txt -m -utf8 -i {} \;
source /home/testuser/project/check_HTML.sh


if [ ${NUM_FAILS} -ne 0 ]; then
  echo .....
  echo Deployment aborted. The ERRORS in the HTML code require human attention. Please fix the code, upload to Github and try deploying again.
  exit 1
fi
#open SQL and shows what was entered in to table in integrtate section
echo .....
echo  "Checking for data entered to the DB during the integration phase"
echo .....

cat<<FINISH | mysql -uroot -ppassword
use dbtest;
select*from custdetails;
FINISH
cd ..
#tar NCIRL and move to deploy folder
tar -czvf pre_deploy.tgz NCIRL
mv pre_deploy.tgz -t /tmp/$SANDBOX/deploy
rm -rf NCIRL
cd ..
echo .....
echo Test stage is complete. Moving to the deployment stage
echo .....
