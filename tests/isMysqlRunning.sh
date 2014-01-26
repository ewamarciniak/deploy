#!/bin/bash
ERRORCOUNT_1=0
ERRORCOUNT_2=0

sudo start mysql
source /home/testuser/project/functions.sh
isMysqlRunning
if [ "$?" -ne 1 ]; then
    ERRORCOUNT_1=$((ERRORCOUNT_1+1))
fi

sudo stop mysql
source /home/testuser/project/functions.sh
isMysqlRunning
if [ "$?" -ne 0 ]; then
    ERRORCOUNT_2=$((ERRORCOUNT_2+1))
fi

ERRORCOUNT=$(($ERRORCOUNT_1+ERRORCOUNT_2))
#ERROR COUNT SHOULD BE 1 after previous
if [ $ERRORCOUNT -eq 0 ] ; then
    echo "Unit test for isMysqlRunning passed."
else
    echo "Unit test for isMysqlRunning failed."
fi
