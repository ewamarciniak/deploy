# awk gets the fifth column, and removes the trailing percentage.
DISKSPACE=`df -H /dev/sda1 | sed '1d' | awk '{print $5}' | cut -d'%' -f1`

# Setting disk capacity threshold
EXTREMEPERC=90
HIGHPERC=75
MINPERC=25
ERRORCOUNT=0
if [ ${DISKSPACE} -ge ${EXTREMEPERC} ]; then
    echo "Disk space is extremely low.${DISKSPACE}% capacity."
	ERRORCOUNT=0
elif [ ${DISKSPACE} -ge ${HIGHPERC} ]; then
    echo "Disk space is very low.${DISKSPACE}% capacity."
elif [ ${DISKSPACE} -lt ${MINPERC} ]; then
    echo "Plenty of disk space left .${DISKSPACE}% capacity."
else
    echo "Disk space capacity: ${DISKSPACE}%."
fi
