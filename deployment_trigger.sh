#!/bin/bash

FILE="deployment_$(date +%Y-%m-%d_%H_%M).log"
sudo  bash /home/testuser/project/myscript.sh | ts | tee  /home/testuser/project/logs/$FILE

echo The Log of this deployment execution was saved in  /home/testuser/project/logs/$FILE






