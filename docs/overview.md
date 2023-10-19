# RNA-Seq Overview

### <div class="job-title">Analysis for Byrne lab</div>
* __Prepared for__: 
    * Alex Byrne (Alexandra.Byrne@umassmed.edu)
    * Brendan Philippon (Brendan.Philippon@umassmed.edu)

* __Prepared by__ : Dan Higgins (daniel.higgins@umassmed.edu)
* __Process Executed on__ : Oct-19-2023

<br>

--- 

### Data Access
* __Dropbox Folder__: RNA-seq/daf19 & tir1 RNAseq Working Files
* __Dropbox URL__: [https://www.dropbox.com/home/RNA-seq/daf19%20%26%20tir1%20RNAseq%20Working%20Files](https://www.dropbox.com/home/RNA-seq/daf19%20%26%20tir1%20RNAseq%20Working%20Files)
* __Rclone Access__: `rclone lsl remote:"RNA-seq/daf19 & tir1 RNAseq Working Files" --human-readable| sed 's/\.000000000//g'`

<br>


#### FASTQ files
```
  1.535Gi 2023-07-18 15:16:40 oxIs12_1/oxIs12_1_1.fq.gz
  1.544Gi 2023-07-18 16:11:31 oxIs12_1/oxIs12_1_2.fq.gz
  1.523Gi 2023-07-18 15:10:12 oxIs12_2/oxIs12_2_1.fq.gz
  1.487Gi 2023-07-18 15:13:25 oxIs12_2/oxIs12_2_2.fq.gz
  1.570Gi 2023-07-18 20:28:42 ABC16_1/ABC16_1_1.fq.gz
  1.573Gi 2023-07-18 20:48:29 ABC16_1/ABC16_1_2.fq.gz
  1.447Gi 2023-07-18 19:50:31 ABC16_2/ABC16_2_1.fq.gz
  1.450Gi 2023-07-18 20:08:56 ABC16_2/ABC16_2_2.fq.gz
  1.457Gi 2023-07-18 18:25:22 ABC284_1/ABC284_1_1.fq.gz
  1.473Gi 2023-07-18 18:43:53 ABC284_1/ABC284_1_2.fq.gz
  1.475Gi 2023-07-18 17:46:37 ABC284_2/ABC284_2_1.fq.gz
  1.497Gi 2023-07-18 18:05:48 ABC284_2/ABC284_2_2.fq.gz
  1.486Gi 2023-07-18 17:08:45 ABC291_1/ABC291_1_1.fq.gz
  1.516Gi 2023-07-18 17:28:05 ABC291_1/ABC291_1_2.fq.gz
  1.502Gi 2023-07-18 16:30:43 ABC291_2/ABC291_2_1.fq.gz
  1.514Gi 2023-07-18 16:50:06 ABC291_2/ABC291_2_2.fq.gz
```

#### Gene Index files

Gene Index based on Wormbase Version: _WS289_

--- 

### RNA Seq Process

<img src="./rna-seq-process-1-700.png" width=700>

### Pipeline Outputs

* MD5 Checksum Report
* FAST QC Report
* Multi QC Report
* Isoform Quantification
* Gene Quantification
* DESeq2 Gene Normalizations (Up, Down, All Expressed) & Visualizations
* WormCat Annotations and Visualizations of gene set enrichment data

### Source Code

The provided tagged repository is available to create reproducible outputs from the RNA-Seq Pipeline.

<div class="blue-background">

<table>
<tr><td><b>Repo</b></td><td><a href="https://github.com/DanH-UMassMed/RNA-Seq-Nextflow">https://github.com/DanH-UMassMed/RNA-Seq-Nextflow</a></td></tr>
<tr><td><b>Source</b></td><td><a href="https://github.com/DanH-UMassMed/RNA-Seq-Nextflow/releases/tag/v1.0.4">https://github.com/DanH-UMassMed/RNA-Seq-Nextflow/releases/tag/v1.0.4</a></td></tr>
</table>

</div>