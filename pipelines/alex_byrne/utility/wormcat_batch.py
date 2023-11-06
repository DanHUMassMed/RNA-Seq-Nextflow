import sys
import os
import pandas as pd

def find_matching_files(directory_path, prefix):
    # Get a list of all directories in the specified path
    all_directories = [d for d in os.listdir(directory_path) if os.path.isdir(os.path.join(directory_path, d))]

    # Filter directories based on the specified prefix
    matching_directories = [d for d in all_directories if d.startswith(prefix)]

    # Iterate through matching directories and find files with the specified pattern
    matching_files = []
    for directory in matching_directories:
        directory_full_path = os.path.join(directory_path, directory)
        files_in_directory = [f for f in os.listdir(directory_full_path) if f.endswith('_alldetected.csv')]
        matching_files.extend([os.path.join(directory_full_path, f) for f in files_in_directory])

    return matching_files


def filter_and_save_csv(foldChange_cutoff, padj_cutoff, direction_change, input_csv_file):
    # Read the CSV file into a pandas DataFrame
    alldetected_df = pd.read_csv(input_csv_file)

    # Filter rows based on the specified conditions
    if direction_change == 'DOWN':
        filtered_df = alldetected_df[(alldetected_df['foldChange'] <= (1 / foldChange_cutoff)) &
                                     (alldetected_df['padj'] <= padj_cutoff)]
    elif direction_change == 'UP':
        filtered_df = alldetected_df[(alldetected_df['foldChange'] >= foldChange_cutoff) &
                                     (alldetected_df['padj'] <= padj_cutoff)]
    else:
        raise ValueError("Invalid direction_change value. Use 'UP' or 'DOWN'.")

    # Write the filtered DataFrame to a new CSV file
    directory_base = os.path.dirname(input_csv_file)
    file_name = os.path.basename(input_csv_file)
    prefix_file_name = file_name[:-len('_alldetected.csv')]
    out_directory_path = os.path.join(directory_base, prefix_file_name)

    if not os.path.exists(out_directory_path):
        os.makedirs(out_directory_path)
    output_csv_file = os.path.join(out_directory_path, f"{direction_change}.csv")
    filtered_df.to_csv(output_csv_file, index=False)
    
    return output_csv_file

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: .py <directory_root> <prefix>")
        sys.exit(1)

    directory_root = sys.argv[1]
    prefix = sys.argv[2]
    foldChange_cutoff=2
    padj_cutoff=0.01
    files_to_process = find_matching_files(directory_root, prefix)
    for file_to_process in files_to_process:
        filter_and_save_csv(foldChange_cutoff, padj_cutoff, "UP", file_to_process)
        filter_and_save_csv(foldChange_cutoff, padj_cutoff, "DOWN", file_to_process)

#python wormcat_batch.py ../results deseq_run
