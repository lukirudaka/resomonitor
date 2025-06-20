#!/usr/bin/bash
## For testing and prototyping usage only 
echo $(free -L --mega | awk -F 'MemUse' '{print $2}' | sed 's/MemFree//' | awk '{print $1}')
