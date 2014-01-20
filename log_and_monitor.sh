#!/bin/bash
# fslyne 2013


ERRORCOUNT=0
TOTAL=0
source /home/testuser/project/check_services_running.sh

if  [ $ERRORCOUNT -gt 0 ];then
        echo "There is a problem with Apache or Mysql"
fi

ERRORCOUNT=0
source /home/testuser/project/check_ports_listening.sh

if  [ $ERRORCOUNT -gt 0 ];then
        echo "The ports are not listening" 
fi

ERRORCOUNT=0
source /home/testuser/project/check_memory.sh

if  [ $ERRORCOUNT -gt 0 ];then
        echo "The memory level is low"
fi

ERRORCOUNT=0
source /home/testuser/project/check_disc_space.sh

if  [ $ERRORCOUNT -gt 0 ];then
        echo "The free disc space level is low"
fi



