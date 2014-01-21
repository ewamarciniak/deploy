
#!/bin/bash
# emarciniak 2014

clear
START=$(date +%s.%N)
echo Starting deployment process
echo .....

#check if memory used is less that 90%
source /home/testuser/project/check_memory.sh
if [ $(echo "$USEDPCT < 90" | bc) -eq 0 ]; then
    echo Cannot continue, the memory used is at the level of 90% or above
    perl /home/testuser/project/mailer.pl
    exit
fi

#check if memory used is less that 90%
source /home/testuser/project/check_disc_space.sh
if [ $ERRORCOUNT -ne 0 ]; then
    echo Cannot continue, disc space used is at a dangerously high level
    perl /home/testuser/project/mailer.pl
    exit
fi

#start clean environment using external script - clean.sh
echo Providing a clean environment
echo .....
source /home/testuser/project/clean.sh

cd /tmp

SANDBOX=sandbox_$RANDOM
echo Created Sandbox: $SANDBOX
echo .....
mkdir $SANDBOX
cd $SANDBOX

# Make the process directories
mkdir build
mkdir integrate
mkdir test
mkdir deploy

#check if apache and mysql are running
source /home/testuser/project/check_services_running.sh
if [ $ERRORCOUNT -eq 0 ]; then
    echo Both mysql and apache2 services are running
    echo .....
else
    echo The services are not running, Error count is higher than 0
    perl /home/testuser/project/mailer.pl
    exit
fi

#run second script will to check if the ports are listening and 
#proceed with build, integrate and test if error count equal to 0
source /home/testuser/project/check_ports_listening.sh
if [ $ERRORCOUNT -ne 0 ]; then
    echo Cannot continue, the ports are not listening, Error count is higher than 0
    perl /home/testuser/project/mail
    exit
fi

#BUILD
#runs build process from external script - build.sh
source /home/testuser/project/build.sh

#INTEGRATE
#runs integrate process from external script - integrate.sh
source /home/testuser/project/integrate.sh

#TEST
#runs test process from external script - test.sh
source /home/testuser/project/test.sh

#DEPLOY
#runs deploy process from external script - deploy.sh
source /home/testuser/project/deploy.sh

service cron start
echo .....
END=$(date +%s.%N)
DIFF=$(echo "($END - $START)" | bc)
DATE=$(date)
echo Sucessfully finished deployment process in $DIFF seconds
echo ..... 
echo The lastest successful deployment took place $DATE and took $DIFF seconds. It used $SANDBOX.  | ts  >>  /home/testuser/project/reports/deployment_record.log 
