#!/usr/bin/env python

import pandas as pd
import os
import sys

OUTPUT_FILE = "genes_expression_expected_count.tsv"
SUFFIX = "genes.results"

def find_files_with_suffix(directory, suffix=SUFFIX):
    matching_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(suffix):
                matching_files.append(os.path.join(root, file))
    return matching_files

def extract_experiment_run_name(file_path):
    directory_path = os.path.dirname(file_path)
    file_name = os.path.basename(file_path)
    run_name = file_name[4:-14]
    return directory_path, run_name

def aggregate_expression_counts(genes_results_files):
    columns_to_keep = ['gene_id', 'expected_count']
    experiment_data_dfs = []

    # Read in all the individual results from RSEM
    for  genes_result_file in genes_results_files:
        df = pd.read_csv(genes_result_file, delimiter='\t')
        df = df.drop(columns=[col for col in df.columns if col not in columns_to_keep])
        directory_path, run_name = extract_experiment_run_name(genes_result_file)
        df = df.rename(columns={'expected_count': run_name})
        experiment_data_dfs.append(df)

    # Aggregate the expected_counts from each file
    merged_df = experiment_data_dfs[0]
    for index in range(1,len(experiment_data_dfs)):
        merged_df = merged_df.merge(experiment_data_dfs[index], on='gene_id', how='left')
    merged_df

    # Write the results in tsv format
    print(f"Writing results to: {OUTPUT_FILE}")
    merged_df.to_csv(f"{OUTPUT_FILE}", sep='\t', index=False)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python rsem_summary.py directory_path")
        sys.exit(1)

    directory_path = sys.argv[1]
    print("Directory path:", directory_path)
    matching_files = find_files_with_suffix(directory_path, SUFFIX)
    aggregate_expression_counts(matching_files)
    