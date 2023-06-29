# Sofware Provided

| Docker Tag | Wormcat Batch|
|------------|--------------|
| 1.0.1      | version 2.0  |

## Wormcat Batch
---

[http://www.wormcat.com/](http://www.wormcat.com/)


WormCat will provide enrichment data from the nested annotation list with broad categories in Category 1 (Cat1) and more specific categories in Cat2 and Cat3. For example, sbp-1 is in Metabolism: lipid: transcriptional regulator. WormCat output provides scaled bubble charts with enrichment scores that meet a Bonferroni false discovery rate cut off of 0.01 as SGV files. The download directory includes CSV files on the data used for the graph (e.g. rgs_fisher_cat1_apv.csv) (apv is appropriate p value). We also include CSV files with categories that have at least one returned gene and p value from Fisher’s exact test (rgs_fisher_cat1.csv). The rgs_and_category.csv file returns the input gene with annotations.

<br>

Once you are comfortable running Wormcat with a single dataset, you may wish to __execute Wormcat with multiple datasets__. Running with multiple datasets is possible by aggregating your datasets into a _Microsoft Excel File_ and using the commadline interface provide with wormcat batch

<br>

You can download an Example Microsoft Excel file [here](http://www.wormcat.com/static/download/Murphy_TS.xlsx) to confirm the required format. Please take care to follow the naming conventions to avoid processing errors.

<br>

<img src="https://www.umassmed.edu/contentassets/4edf0cb3ed5245c2883e9bd514462c72/wormcat-graphic-for-web-768x436.jpg" alt="Alt Text">

<br>
<br>

<br>

# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.