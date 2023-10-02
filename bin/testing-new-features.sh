#/bin/bash

read_1=$1
read_2=$2
data_root=$3
dir_suffix=$4
trim_control=$5

# Determine the original directory structure for these files
real_path=`readlink -f $read_1`
path_without_filename=$(dirname "$real_path")
path_to_data="test_${dir_suffix}/${path_without_filename#*$data_root}"

# Recreate the directory structure for the output
mkdir -p "${path_to_data}"

# trimmomatic simulation
cp ${read_1} paired_${read_1}
cp ${read_2} paired_${read_2}

cp paired_* "${path_to_data}/"
