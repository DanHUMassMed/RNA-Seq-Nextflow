# RNA-Seq Overview

### <div class="job-title">Analysis for Francis lab</div>
* __Prepared for__: 
    * Mike Francis (michael.francis@umassmed.edu)
    * Sam Liu (samuel.liu@umassmed.edu)
* __Prepared by__ : Dan Higgins (daniel.higgins@umassmed.edu)
* __Process Executed on__ : Oct-16-2023

<br>

--- 

### Data Access
* __Dropbox Folder__: UMass Medical School/SamLiu_ Francis lab September 2023
* __Dropbox URL__: [https://www.dropbox.com/scl/fo/c3uulk12omzwo5ex5reqz/h?rlkey=dw5qvybhkm76emqi3j347ert1&dl=0](https://www.dropbox.com/scl/fo/c3uulk12omzwo5ex5reqz/h?rlkey=dw5qvybhkm76emqi3j347ert1&dl=0)
* __Rclone Access__: `rclone lsl remote:"SamLiu_ Francis lab September 2023" --human-readable| sed 's/\.000000000//g'`

<br>


#### FASTQ files
```
2.511Gi 2023-09-28 09:20:38 Wild Type/SLWA_N2A_1.fq.gz
2.766Gi 2023-09-28 09:20:37 Wild Type/SLWA_N2A_2.fq.gz
1.810Gi 2023-09-28 09:22:29 Wild Type/SLWA_N2B_1.fq.gz
1.967Gi 2023-09-28 09:22:28 Wild Type/SLWA_N2B_2.fq.gz
1.554Gi 2023-09-28 09:16:56 dve1 mutant/SLWA_DVE1A_1.fq.gz
1.703Gi 2023-09-28 09:17:02 dve1 mutant/SLWA_DVE1A_2.fq.gz
1.573Gi 2023-09-28 09:18:23 dve1 mutant/SLWA_DVE1B_1.fq.gz
1.705Gi 2023-09-28 09:18:21 dve1 mutant/SLWA_DVE1B_2.fq.gz
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
<tr><td><b>Source</b></td><td><a href="https://github.com/DanH-UMassMed/RNA-Seq-Nextflow/releases/tag/v1.0.3">https://github.com/DanH-UMassMed/RNA-Seq-Nextflow/releases/tag/v1.0.3</a></td></tr>
</table>

</div>