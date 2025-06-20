#!/usr/bin/bash

while true; do
    ### Ratelimiter
    ### Update once every X seconds.
    sleep 0.25

    ### Section A: Pulling thermals.
    ### CPU, GPU
    echo $(sensors | grep CPUTIN | cut -c 29-30)°C > cputemp
    echo $(nvidia-settings -q GPUCoreTemp | grep Attribute | cut -c 38-39)°C > gputemp

    ### Section B: Pulling usage
    ### RAM, CPU overall, GPU overall

    ## show memory stats in a single line in megabytes, then cut everything before the phrase MemUse, cut out MemFree, print first value, add MB to the end. Pipe result to "ramusage".
    echo $(free -L --mega | awk -F 'MemUse' '{print $2}' | sed 's/MemFree//' | awk '{print $1}')' MB' > ramusage
    ## show cpu line in /proc/stat.. uhh.. heck idk what the rest does. this was off stack overflow. cut percentage out at the end and pipe it to cpuusage.
    echo $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage ""}' | cut -c 1-2)'%' > cpuusage
    ## query GPU utilization from nvidia-smi, bring it down to the line that contains the overall utilization, cut it to the characters containing the value, delete the percentage.
    echo $(nvidia-smi -q -d UTILIZATION | grep "        GPU                               :" | cut -c 45-50 | sed 's/%//') > gpuusage
    ## query GPU VRAM usage from nvidia-smi, grep the first used instance, limit it to only numbers, add MB to the end, and write output to vramusage
    echo $(nvidia-smi -q -d memory | grep "Used" -m 1 | grep -o -E '[0-9]+')' MB' > vramusage
done
