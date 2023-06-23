#!/bin/bash
base_dir=`pwd`
## Find all the files that where transfered over and unzip
for full_path in `find . -name "*fq.gz" |sort`;
do	
	bsub  -q short -W 0:30 -R rusage[mem=10000] -n 1 gunzip $base_dir/${full_path:2}
done
