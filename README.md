# RNA-Seq Analysis for Alex Byrne Lab

* 1a. Get Dropbox data and move it to the HPC `(get_dropbox_data-alex.nf)`
* 1b. Check the MD5 Checksum values for the transferred data
* 2a.  Get genome data from Wormbase for alignment `(utility/wormbase_download.sh)`
* 3a.  Create STAR and rsem indexes `(create_star_rsem_index.nf)`
* 3a.  Create Salmon index file `(create_salmon_index.nf)`
    * NOTE Salmon process is currently used for testing and validation only
* 4a. Execute Quality Control on FASTQ Data `(rnaseq-rsem-alex.nf)`
* 4b. Align FASTQ data to the Worm Genome
* 4c. Quantify the Gene Expression 
* 4d. Summarize results for further analysis
* 4e. Aggregate the QC Reports for simplified review 
* 5a. DEBrowser perform Differencial Expression Analysis `(utility/start_debrowser.sh)`
* 6a. Wormcat Batch Execution `(wormcat_batch.nf)`
