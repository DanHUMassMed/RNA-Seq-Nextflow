#!/bin/bash

# Get the data from Dropbox
data_remote=$1
data_local=$2

# Get the directories to be copied
directories=()
for exp_dir in `rclone lsd remote:"${data_remote}"|cut -f22 -d' '`;
do
    directories+=($exp_dir)
done
length=${#directories[@]}

# Iterate over the directories and provide the time it takes to copy
# also provide info on the number of files to copy and how many have been copies so far
counter=0
for exp_dir in "${directories[@]}";
do
    (( counter++ ))
    echo copying ${exp_dir} which is $counter of $length
    start_time=$(date +%s) 
    rclone copy "remote:${data_remote}/${exp_dir}" ${data_local}/${exp_dir}
    end_time=$(date +%s) 
    execution_time=$((end_time - start_time))

    # Calculate minutes and seconds
    minutes=$((execution_time / 60))
    seconds=$((execution_time % 60))

    echo "Execution time: $minutes minutes and $seconds seconds"
done