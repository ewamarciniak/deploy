if ping -W 5 -c 1 google.com >/dev/null; then
    echo "Internet is up."
else
    echo "Connection is down. Exiting deployment process"    
    exit
fi
