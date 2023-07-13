#!/bin/bash
data_local="/home/daniel.higgins-umw/project_data/alex_byrne/data"
cd $data_local

base_dir=`pwd`
for full_path in `find . -name "*fq"`;
do	
    mv $full_path $data_local
done

for full_path in `find . -mindepth 1 -maxdepth 1 -type d`;
do	
    rm -rf $full_path
done

