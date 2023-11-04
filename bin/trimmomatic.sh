#/bin/bash

read_1=$1
read_2=$2
data_root=$3
dir_suffix=$4
trim_control=$5

# Determine the original directory structure for these files
real_path=`readlink -f $read_1`
path_without_filename=$(dirname "$real_path")
path_to_data="trim_${dir_suffix}/${path_without_filename#*$data_root}"

# Recreate the directory structure for the output
mkdir -p "${path_to_data}"

#-trimlog trimlog.txt
trimmomatic PE -threads 4 -phred33 \
            ${read_1} ${read_2} \
            T_${read_1} unpaired_${read_1} \
            T_${read_2} unpaired_${read_2} \
            ${trim_control}

# # trimmomatic simulation
# cp ${read_1} paired_${read_1}
# cp ${read_2} paired_${read_2}
# echo "Log out" >trimlog.txt

cp T_* "${path_to_data}/"
#cp trimlog.txt "${path_to_data}/"
