
#!/bin/bash
ERRORCOUNT_1=0
ERRORCOUNT_2=0

sudo /etc/init.d/apache2 start
source /home/testuser/project/functions.sh
isApacheRunning
if [ "$?" -ne 1 ]; then
    ERRORCOUNT_1=$((ERRORCOUNT_1+1))
fi
 
sudo /etc/init.d/apache2 stop
source /home/testuser/project/functions.sh
isApacheRunning
if [ "$?" -ne 0 ]; then
    ERRORCOUNT_2=$((ERRORCOUNT_2+1))
fi

ERRORCOUNT=$(($ERRORCOUNT_1+ERRORCOUNT_2))
#ERROR COUNT SHOULD BE 1 after previous
if [ $ERRORCOUNT -eq 0 ] ; then
    echo "Unit test for isApacheRunning passed."
else
    echo "Unit test for isApacheRunning passed."
fi
