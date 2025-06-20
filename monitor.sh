#!/usr/bin/bash
## Create a loop.
## The first line is a timer. It represents, in seconds, how often you want to update the webserver's values
## The second line prints the current CPU temperature, then writes it to the cputemp file.
## The third line queries the GPU core temperature from nvidia-settings, narrows it down to one line (the line with the value itself), narrows it down to the value itself, and adds the degrees celsius symbol to the end. It then writes it to the gputemp file.
## The fourth line queries RAM usage in megabytes. This outputs in a single line already. It would otherwise output in columns, which would be a nightmare to pull data from. It ignores values before MemUse, cuts out MemFree and what comes after it, then prints the first argument, and adds the megabytes symbol to the end.
while true; do
    sleep 0.25
    echo $(sensors | grep CPUTIN | cut -c 29-30)°C > ./cputemp 
    echo $(nvidia-settings -q GPUCoreTemp | grep Attribute | cut -c 38-39)°C > ./gputemp
    echo $(free -L --mega | awk -F 'MemUse' '{print $2}' | sed 's/MemFree//' | awk '{print $1}')' MB' > ./ramusage
done
