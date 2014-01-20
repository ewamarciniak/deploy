
#!/bin/bash

source /home/testuser/project/functions.sh

#checks errors for myscript

ERRORCOUNT=0

isApacheListening
if [ "$?" -eq 1 ]; then
        echo Apache is Listening
else
        echo Apache is not Listening
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isMysqlListening
if [ "$?" -eq 1 ]; then
        echo Mysql is Listening
else
        echo Mysql is not Listening
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

echo errorcount is: $ERRORCOUNT
