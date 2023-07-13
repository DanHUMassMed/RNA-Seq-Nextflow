#!/bin/bash
data_local="/home/daniel.higgins-umw/project_data/alex_byrne/data"
cd $data_local

calculate_md5() {
  local file_path="$1"
  local md5_hash

  # Run md5sum command and extract the hash
  md5_hash=$(md5sum "$file_path" | awk '{ print $1 }')
  
  # Return the MD5 hash
  echo "$md5_hash"
}

md5_hashes=()
for md5_file in `find . -name MD5.txt|sort`;
do 
        # Get the directory path from the full file name
        directory=$(dirname "$md5_file")
        # Replace the 2 blanks with an = sign
        key_value=$(cat "$md5_file" | sed 's/  /=/g')
        # Add the directory path to the file name for the md5 file
        key_value=$(echo "$key_value" | sed "s/=/=\$${directory//\//\\/}\//")
        key_value=$(echo "$key_value" | sed "s/=[$]/=/g")
        # Add the key value hash=file_nm to the array of hashes
       
        md5_hashes+=($key_value);
done;

for md5_hash in "${md5_hashes[@]}";
do

    hash_key="${md5_hash%%=*}"
    dir_value="${md5_hash#*=}"
    
    calc_hash=$(calculate_md5 "$dir_value")
    # Print the MD5 hash

    if [ "$calc_hash" == "$hash_key" ]; then
        echo "$dir_value PASS"
    else
        echo "$dir_value $calc_hash $hash_key FAIL"
    fi

done

# ./BiGb0552_1/BiGb0552_1_1.fq.gz 69317fdda7f21bc132ce26f801977198 0da27b13bb60a5fe34648d6f4c44823f FAIL
# ./BiGb0552_1/BiGb0552_1_2.fq.gz PASS
# ./BiGb0552_2/BiGb0552_2_1.fq.gz PASS
# ./BiGb0552_2/BiGb0552_2_2.fq.gz PASS
# ./BiGb0552_3/BiGb0552_3_1.fq.gz PASS
# ./BiGb0552_3/BiGb0552_3_2.fq.gz PASS
# ./BiGb411_1/BiGb411_1_1.fq.gz PASS
# ./BiGb411_1/BiGb411_1_2.fq.gz PASS
# ./BiGb411_2/BiGb411_2_1.fq.gz PASS
# ./BiGb411_2/BiGb411_2_2.fq.gz PASS
# ./BiGb411_3/BiGb411_3_1.fq.gz PASS
# ./BiGb411_3/BiGb411_3_2.fq.gz PASS
# ./OP50_1/OP50_1_1.fq.gz c7ef0cca1807ba9bc616d2c2bb94a3cb 66833e65cf108e6bdc3313c7e4086d61 FAIL
# ./OP50_1/OP50_1_2.fq.gz PASS
# ./OP50_2/OP50_2_1.fq.gz PASS
# ./OP50_2/OP50_2_2.fq.gz PASS
# ./OP50_3/OP50_3_1.fq.gz PASS
# ./OP50_3/OP50_3_2.fq.gz PASS

# Because BiGb0552_1/BiGb0552_1_1 and OP50_1/OP50_1_1 fail we will drop all *_1 expieriments
# rm -rf BiGb0552_1 OP50_1 BiGb411_1
