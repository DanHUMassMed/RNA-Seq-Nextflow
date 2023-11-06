#!/bin/bash -ue
# NOTE: Input files are not following a consistent convention and need to renamed to provide consistent names for analysis

# Change directory to base of directory where data_files are to be renamed
# working_dir="$1"
working_dir="/home/daniel.higgins-umw/project_data/RNA-Seq-Nextflow/data/mike_francis"
cd $working_dir

# Function to check if a file exists and rename it if it does
rename_file_if_exists() {
    source_file="$1"
    new_name="$2"
    if [ -e "$source_file" ]; then
        # Extract the directory path and filename from the source file path
        directory="$(dirname "$source_file")"
        filename="$(basename "$source_file")"

        # Create the new file path by joining the directory path and new name
        new_file_path="$directory/$new_name"

        # Use the 'mv' command to rename the file
        mv "$source_file" "$new_file_path"
        echo "File ${filename} renamed successfully."
    else
        echo "File ${source_file} does not exist."
    fi
}


rename_file_if_exists "./WT_N2_L4/N2_r3/N2_1.fq.gz" "N2_r3_1.fq.gz"
rename_file_if_exists "./WT_N2_L4/N2_r3/N2_2.fq.gz" "N2_r3_2.fq.gz"

rename_file_if_exists "./eat4_ky5_L4/eat4_ky5_r2/eat4_ky5r2_1.fq.gz" "eat4_ky5_r2_1.fq.gz"
rename_file_if_exists "./eat4_ky5_L4/eat4_ky5_r2/eat4_ky5r2_2.fq.gz" "eat4_ky5_r2_2.fq.gz"
rename_file_if_exists "./eat4_ky5_L4/eat4_ky5_r3/eat4_ky5_1.fq.gz"   "eat4_ky5_r3_1.fq.gz"
rename_file_if_exists "./eat4_ky5_L4/eat4_ky5_r3/eat4_ky5_2.fq.gz"   "eat4_ky5_r3_2.fq.gz"
rename_file_if_exists "./eat4_ky5_L4/eat4_ky5_r4/eat4_ky5r4_1.fq.gz" "eat4_ky5_r4_1.fq.gz"
rename_file_if_exists "./eat4_ky5_L4/eat4_ky5_r4/eat4_ky5r4_2.fq.gz" "eat4_ky5_r4_2.fq.gz"

rename_file_if_exists "./unc17_e113_L4/unc17_e113_r2/unc17_e113r2_1.fq.gz" "unc17_e113_r2_1.fq.gz"
rename_file_if_exists "./unc17_e113_L4/unc17_e113_r2/unc17_e113r2_2.fq.gz" "unc17_e113_r2_2.fq.gz"
rename_file_if_exists "./unc17_e113_L4/unc17_e113_r3/unc17_e113_1.fq.gz"   "unc17_e113_r3_1.fq.gz"
rename_file_if_exists "./unc17_e113_L4/unc17_e113_r3/unc17_e113_2.fq.gz"   "unc17_e113_r3_2.fq.gz"
rename_file_if_exists "./unc17_e113_L4/unc17_e113_r4/unc17_e113r4_1.fq.gz" "unc17_e113_r4_1.fq.gz" 
rename_file_if_exists "./unc17_e113_L4/unc17_e113_r4/unc17_e113r4_2.fq.gz" "unc17_e113_r4_2.fq.gz"

