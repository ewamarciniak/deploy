
#!/bin/bash
# emarciniak 2014

clear
START=$(date +%s.%N)
echo Starting deployment process
echo .....
echo Providing a clean environment
echo .....
#check if memory used is less that 90%
source /home/testuser/project/check_memory.sh
if [ $(echo "$USEDPCT < 90" | bc) -ne 0 ]; then

#check if memory used is less that 90%
source /home/testuser/project/disc_space_check.sh
if [ $ERRORCOUNT -eq 0 ]; then

#start clean environment using external script - clean.sh
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
exit 1
fi


#run second script will to check if the ports are listening and 
#proceed with build, integrate and test if error count equal to 0
source /home/testuser/project/check_tcp_ports_listening.sh
if [ $ERRORCOUNT -eq 0 ]; then

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
else
echo Cannot continue, the ports are not listening, Error count is higher than 0
perl /home/testuser/project/mailer.pl
fi

else 
echo Cannot continue, disc space used is at a dangerously high level
perl /home/testuser/project/mailer.pl
fi

else 
echo Cannot continue, the memory used is at the level of 90% or above
perl /home/testuser/project/mailer.pl
fi
echo .....
END=$(date +%s.%N)
DIFF=$(echo "($END - $START)" | bc)
echo Finished deployment process in $DIFF seconds