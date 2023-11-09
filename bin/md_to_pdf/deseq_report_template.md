# RNA Seq Differential Gene Expression Analysis
    
### <div class="job-title">{title}</div>

* __Prepared for__: 

{prepared_for}

* __Prepared by__ : {prepared_by}

* __Process Executed on__ : {process_date}

* __Input Data__: genes_expression_expected_count.tsv

<br>

--- 

## DE Seq Data Preparation

### Low Count Filtering 

* __Criteria__: Filter features where MAX Value < 10

<br>

<!-- Place 2 Histogram Plots Before and After -->
<!-- Place 2 Summary Tables of counts Before and After -->

<br>

---

## DE Seq Execution

<div style="display: flex; justify-content: space-between;">
    <table class="flex-table">
        <tr><th colspan="2" style="background-color: #3e8dbc; color: white;text-align: center;">Before Low Count Filter</th></tr>
        <tr><th>lib-name</th><th>counts</th></tr>
        <tr><td>paired_ABC16_1</td><td>19,190,638</td></tr>
        <tr><td>paired_ABC16_2</td><td>17,330,026</td></tr>
        <tr><td>paired_ABC284_1</td><td>17,694,487</td></tr>
        <tr><td>paired_ABC284_2</td><td>17,884,691</td></tr>
        <tr><td>paired_ABC291_1</td><td>18,074,080</td></tr>
        <tr><td>paired_ABC291_2</td><td>18,068,754</td></tr>
        <tr><td>paired_oxIs12_1</td><td>18,859,556</td></tr>
        <tr><td>paired_oxIs12_2</td><td>18,688,418</td></tr>
    </table>
    <table class="flex-table">
    <tr><th colspan="2" style="background-color: #3e8dbc; color: white;text-align: center;">After Low Count Filter</th></tr>
    <tr><th>lib-name</th><th>counts</th></tr>
    <tr><td>paired_ABC16_1</td><td>19,185,976</td></tr>
    <tr><td>paired_ABC16_2</td><td>17,326,294</td></tr>
    <tr><td>paired_ABC284_1</td><td>17,690,119</td></tr>
    <tr><td>paired_ABC284_2</td><td>17,878,201</td></tr>
    <tr><td>paired_ABC291_1</td><td>18,069,420</td></tr>
    <tr><td>paired_ABC291_2</td><td>18,064,007</td></tr>
    <tr><td>paired_oxIs12_1</td><td>18,855,139</td></tr>
    <tr><td>paired_oxIs12_2</td><td>18,684,300</td></tr>
    </table>
</div>

<br>

<div style="display: flex; justify-content: space-between;">
    <img src="low_count_summary/log10_Foldchange_before_filtering.png" alt="Left Image" style="width: 48%;">
    <img src="low_count_summary/log10_Foldchange_after_filtering.png" alt="Right Image" style="width: 48%;">
</div>

<br>
<br>

## Differential Expression Results

### OSLX12-ABC16



<img src="deseq_run_oxIs12_ABC16/run_oxIs12_ABC16_dispersion_plot.svg" alt="Left Image" style="width: 48%;">

<br>
<br>

<div style="display: flex; justify-content: space-between;">
    <img src="deseq_run_oxIs12_ABC16/run_oxIs12_ABC16_scatter_plot.png" alt="Left Image" style="width: 48%;">
    <img src="deseq_run_oxIs12_ABC16/run_oxIs12_ABC16_volcano_plot.png" alt="Right Image" style="width: 48%;">
</div>

<br>
<br>

<div style="display: flex; justify-content: space-between;">
    <img src="deseq_run_oxIs12_ABC16/run_oxIs12_ABC16_heatmap_plot.png" alt="Left Image" style="width: 48%;">
    <img src="deseq_run_oxIs12_ABC16/run_oxIs12_ABC16_pca_plot.png" alt="Right Image" style="width: 48%;">
</div>

