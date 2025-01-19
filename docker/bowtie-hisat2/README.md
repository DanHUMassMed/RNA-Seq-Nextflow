# Sofware Provided

| Docker Tag | samtools  | Bowtie2  | HISAT2  |
|------------|-----------|----------|---------|
| 1.0.2      | v1.21     | v2.5.4   | v2.2.1  |


## Salmtools
---

[http://www.htslib.org/](http://www.htslib.org/)

Samtools is a suite of programs for interacting with high-throughput sequencing data. It consists of three separate repositories:

* __Samtools__ Reading/writing/editing/indexing/viewing SAM/BAM/CRAM format
* __BCFtools__ Reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants
* __HTSlib__ A C library for reading/writing high-throughput sequencing data

Samtools and BCFtools both use HTSlib internally, but these source packages contain their own copies of htslib so they can be built independently.

<br>

## Bowtie2
---

[https://bowtie-bio.sourceforge.net/bowtie2/index.shtml](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml)


__Bowtie 2__ is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences. It is particularly good at aligning reads of about 50 up to 100s or 1,000s of characters, and particularly good at aligning to relatively long (e.g. mammalian) genomes. Bowtie 2 indexes the genome with an FM Index to keep its memory footprint small: for the human genome, its memory footprint is typically around 3.2 GB. Bowtie 2 supports gapped, local, and paired-end alignment modes.

<br>

## HISTAT2
---

[https://daehwankimlab.github.io/hisat2/](https://daehwankimlab.github.io/hisat2/)


__HISAT2__ is a fast and sensitive alignment program for mapping next-generation sequencing reads (both DNA and RNA) to a population of human genomes as well as to a single reference genome. Based on an extension of BWT for graphs (Sirén et al. 2014), we designed and implemented a graph FM index (GFM), an original approach and its first implementation. In addition to using one global GFM index that represents a population of human genomes, HISAT2 uses a large set of small GFM indexes that collectively cover the whole genome. These small indexes (called local indexes), combined with several alignment strategies, enable rapid and accurate alignment of sequencing reads. This new indexing scheme is called a Hierarchical Graph FM index (HGFM).



<br>
# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.

<br>

