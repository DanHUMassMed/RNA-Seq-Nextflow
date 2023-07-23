#!/bin/bash
data_local=$1

current_dir=$(pwd)
report_file_name="${current_dir}/md5_report.html"

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



printf "<html>\n<head>\n\t<title>MD5 Check Report</title>\n</head>\n" > ${report_file_name}
printf "<body>\n\t<h1>MD5 Check Report</h1>\n\t<table border=1>\n\t\t<tr>\n\t\t\t<th>File</th><th>Status</th>\n\t\t</tr>\n" >> ${report_file_name}
for md5_hash in "${md5_hashes[@]}";
do

    hash_key="${md5_hash%%=*}"
    dir_value="${md5_hash#*=}"
    
    calc_hash=$(calculate_md5 "$dir_value")
    # Print the MD5 hash

    status="<td style='color: red;'>FAIL</td>"
    if [ "$calc_hash" == "$hash_key" ]; then
        status="<td style='color: green;'>PASS</td>"
    fi
    printf "\t\t<tr>\n\t\t\t<td>%s</td>%s\n\t\t</tr>\n" "$dir_value" "$status" >> ${report_file_name}

done
printf "\t</table>\n</body>\n</html>" >> ${report_file_name}

