#!/bin/bash

sudo  bash /home/testuser/project/myscript.sh | ts | tee  /home/testuser/project/tests/"acceptance_$(date +%Y-%m-%d_%H:%M).log"
