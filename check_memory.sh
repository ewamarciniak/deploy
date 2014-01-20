#!/bin/bash
top -n 1 -b | grep "Mem" > /home/testuser/project/top-output.txt
MAXMEM=$(grep "Mem" /home/testuser/project/top-output.txt | cut -c 7-14)
USEDMEM=$(grep "Mem" /home/testuser/project/top-output.txt | cut -c 25-31)
USEDPCT=$(echo "scale=3; $USEDMEM / $MAXMEM * 100" | bc -l)
echo "Percent of memory used: $USEDPCT" 
