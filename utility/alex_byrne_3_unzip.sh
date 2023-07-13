#!/bin/bash
data_local="/home/daniel.higgins-umw/project_data/alex_byrne/data"
cd $data_local

base_dir=`pwd`
## Find all the files that where transfered over and unzip
for full_path in `find . -name "*fq.gz" |sort`;
do	
    echo "bsub gunzip $base_dir/${full_path:2}"
	bsub  -q short -W 0:30 -R rusage[mem=10000] -n 1 gunzip $base_dir/${full_path:2}
done
