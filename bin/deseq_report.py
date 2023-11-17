#!/usr/bin/env python3

import argparse
import subprocess
import json
import sys
import os
import markdown
import pandas as pd
from markdown_include.include import MarkdownInclude
from weasyprint import HTML



REPORT_TEMPLATE_FILE = "./deseq_report_template.md"
REPORT_TEMPLATE_CSS = "./report_template.css"
DESEQ_REPORT_MD = "./deseq_report.md"
LOW_COUNTS_FILTERED="./low_count_summary/count_data_low_counts_filtered.tsv"
RSEM_COUNTS="./rsem_summary/genes_expression_expected_count.tsv"

def add_title_page(json_file, report_data={}):
    # Extract values from JSON data
    # Read JSON data from file
    with open(json_file, 'r') as file:
        json_data = json.load(file)
    
    prepared_for = ""
    for person in json_data['prepared_for']:
        prepared_for += f"\t* {person} \n"
    
    report_data['title'] = json_data['title'] 
    report_data['process_date'] = json_data['process_date']
    report_data['prepared_by'] = json_data['prepared_by'] 
    report_data['prepared_for'] = prepared_for 
 
    return report_data 


def get_counts_summary(counts_file):
    counts_df = pd.read_csv(counts_file, delimiter='\t')
    counts_df = counts_df.drop('gene_id', axis=1)
    for col in counts_df.columns:
        if pd.api.types.is_numeric_dtype(counts_df[col]):
            counts_df[col] = counts_df[col].astype(int, errors='ignore')

    column_sums = counts_df.sum()
    column_sums = column_sums.sort_index()
    return column_sums

def add_low_counts_filter_table(report_data):
    counts_before = get_counts_summary(RSEM_COUNTS)
    counts_after =get_counts_summary(LOW_COUNTS_FILTERED)
    counts_summary_df = pd.concat([counts_before, counts_after], axis=1, keys=['Before', 'After'])

    html_table  = "<table style= 'width: 600px;'>\n"
    html_table += "\t<tr><th colspan='3' style='background-color: #3e8dbc; color: white;text-align: center;'>Low Count Filter</th></tr>\n"
    html_table += "\t<tr><th>lib-name</th><th>Before</th><th>After</th></tr>\n"
    
    html_rows = ''
    for idx, row in counts_summary_df.iterrows():
        html_rows += f"\t<tr><td>{idx}</td><td>{row['Before']:,}</td><td>{row['After']:,}</td></tr>\n"

    html_table += html_rows
    html_table += "</table>\n" 

    report_data['low_counts_table']= html_table
    return report_data

def add_deseq_run_details(report_data):
    current_dir = './'
    # Get all directories in the specified directory
    all_directories = [d for d in os.listdir(current_dir) if os.path.isdir(os.path.join(current_dir, d))]

    # Filter directories with the prefix 'desk_run'
    prefix = 'deseq_'
    filtered_directories = [d for d in all_directories if d.startswith(prefix)]

    # Display the filtered directories
    print(f"Directories with prefix '{prefix}':")
    html = "<h2>DESeq2 Results</h2>\n"
    experiment = 0
    for directory in filtered_directories:
       experiment += 1
       page_break = "style='page-break-before: always;'" if experiment > 1 else ""
       html += f"<h3 {page_break}>Experiment {directory[6:]}</h3>\n"
       ### HACK FOR NOW
       if directory[6:] == "run_N2_ky5":
          html += hack_ky5_tables()
       elif directory[6:] == "run_N2_e113": 
          html += hack_e113_tables()
       
       html += "<br>\n"
       html += add_two_img_div(f"{directory}/plots", f"{directory[6:]}_scatter_plot.png",f"{directory[6:]}_volcano_plot.png") 
       html += "<br>\n"
       html += add_two_img_div(f"{directory}/plots", f"{directory[6:]}_heatmap_plot.png",f"{directory[6:]}_pca_plot.png")
       #html += "<br>\n"
       #html += add_data_image_div(f"{directory}/plots", f"{directory[6:]}_dispersion_plot.svg")

    report_data['differential_results'] = html
    return report_data

def hack_ky5_tables():
    html = ""
    html +="<table class='bordered-table styled-table' style= 'width: 600px;'>\n"
    html +="    <tr><th colspan='4' style='text-align: center;border-bottom: 1px solid white;'>Top 10 ky5_up</th></tr>\n"
    html +="    <tr><th>Wormbase_Id</th><th>Sequence_id</th><th>Gene_name</th><th>log2FoldChange</th></tr>\n"
    html +="<tr><td>WBGene00002015</td><td>T27E4.8</td><td>hsp-16.1</td><td>8.3782</td>\n"
    html +="<tr><td>WBGene00018619</td><td>F48G7.8</td><td>nan</td><td>8.2392</td>\n"
    html +="<tr><td>WBGene00014047</td><td>ZK666.7</td><td>clec-61</td><td>7.6906</td>\n"
    html +="<tr><td>WBGene00018527</td><td>F47B3.3</td><td>nan</td><td>7.3259</td>\n"
    html +="<tr><td>WBGene00011674</td><td>T10B9.4</td><td>cyp-13A8</td><td>7.0591</td>\n"
    html +="<tr><td>WBGene00009857</td><td>F49A5.5</td><td>clec-28</td><td>6.9792</td>\n"
    html +="<tr><td>WBGene00019623</td><td>K10C9.1</td><td>nan</td><td>6.9023</td>\n"
    html +="<tr><td>WBGene00021580</td><td>Y46C8AL.2</td><td>clec-174</td><td>6.7939</td>\n"
    html +="<tr><td>WBGene00016670</td><td>C45G7.3</td><td>ilys-3</td><td>6.0499</td>\n"
    html +="<tr><td>WBGene00014046</td><td>ZK666.6</td><td>clec-60</td><td>5.9399</td>\n"
    html +="</table>\n"
    html +="<br>\n"
    html +="<table class='bordered-table styled-table' style= 'width: 600px;'>\n"
    html +="    <tr><th colspan='4' style='text-align: center;border-bottom: 1px solid white;'>Top 10 ky5_down</th></tr>\n"
    html +="    <tr><th>Wormbase_Id</th><th>Sequence_id</th><th>Gene_name</th><th>log2FoldChange</th></tr>\n"
    html +="<tr><td>WBGene00004994</td><td>T25C12.2</td><td>spp-9</td><td>-12.5449</td>\n"
    html +="<tr><td>WBGene00018911</td><td>F56A4.3</td><td>nan</td><td>-9.1567</td>\n"
    html +="<tr><td>WBGene00235356</td><td>Y67D8A.10</td><td>nan</td><td>-8.2468</td>\n"
    html +="<tr><td>WBGene00249808</td><td>Y48G8AL.20</td><td>nan</td><td>-8.1195</td>\n"
    html +="<tr><td>WBGene00018601</td><td>F48C1.9</td><td>nan</td><td>-7.1819</td>\n"
    html +="<tr><td>WBGene00018918</td><td>F56A4.10</td><td>nan</td><td>-7.1207</td>\n"
    html +="<tr><td>WBGene00008911</td><td>F17C8.6</td><td>nan</td><td>-5.7830</td>\n"
    html +="<tr><td>WBGene00004997</td><td>T22G5.7</td><td>spp-12</td><td>-5.0448</td>\n"
    html +="<tr><td>WBGene00001387</td><td>F15B9.1</td><td>far-3</td><td>-4.6489</td>\n"
    html +="<tr><td>WBGene00304815</td><td>Y40A1A.6</td><td>nan</td><td>-3.6454</td>\n"
    html +="</table>\n"
    html +="<br>\n"
    return html

def hack_e113_tables():
    html = ""
    html +="<table class='bordered-table styled-table' style= 'width: 600px;'>\n"
    html +="    <tr><th colspan='4' style='text-align: center;border-bottom: 1px solid white;'>Top 10 e113_up</th></tr>\n"
    html +="    <tr><th>Wormbase_Id</th><th>Sequence_id</th><th>Gene_name</th><th>log2FoldChange</th></tr>\n"
    html +="<tr><td>WBGene00019449</td><td>K06H6.1</td><td>nan</td><td>8.7857</td>\n"
    html +="<tr><td>WBGene00008477</td><td>E03H4.10</td><td>clec-17</td><td>8.1643</td>\n"
    html +="<tr><td>WBGene00015760</td><td>C14C6.6</td><td>nan</td><td>8.0394</td>\n"
    html +="<tr><td>WBGene00000749</td><td>ZC373.7</td><td>col-176</td><td>7.9397</td>\n"
    html +="<tr><td>WBGene00019623</td><td>K10C9.1</td><td>nan</td><td>7.7387</td>\n"
    html +="<tr><td>WBGene00008816</td><td>F14F8.8</td><td>nan</td><td>7.6263</td>\n"
    html +="<tr><td>WBGene00000618</td><td>T10B10.1</td><td>col-41</td><td>7.6213</td>\n"
    html +="<tr><td>WBGene00001068</td><td>F16F9.2</td><td>dpy-6</td><td>7.4190</td>\n"
    html +="<tr><td>WBGene00022816</td><td>ZK783.1</td><td>fbn-1</td><td>7.2069</td>\n"
    html +="<tr><td>WBGene00018619</td><td>F48G7.8</td><td>nan</td><td>7.2012</td>\n"
    html +="</table>\n"
    html +="<br>\n"
    html +="<table class='bordered-table styled-table' style= 'width: 600px;'>\n"
    html +="    <tr><th colspan='4' style='text-align: center;border-bottom: 1px solid white;'>Top 10 e113_down</th></tr>\n"
    html +="    <tr><th>Wormbase_Id</th><th>Sequence_id</th><th>Gene_name</th><th>log2FoldChange</th></tr>\n"
    html +="<tr><td>WBGene00018911</td><td>F56A4.3</td><td>nan</td><td>-9.4636</td>\n"
    html +="<tr><td>WBGene00022495</td><td>Y119D3B.19</td><td>fbxa-78</td><td>-7.1588</td>\n"
    html +="<tr><td>WBGene00045270</td><td>C04E7.5</td><td>nan</td><td>-7.0679</td>\n"
    html +="<tr><td>WBGene00007459</td><td>C08F11.12</td><td>nan</td><td>-6.9570</td>\n"
    html +="<tr><td>WBGene00018062</td><td>F35F10.13</td><td>nan</td><td>-6.2779</td>\n"
    html +="<tr><td>WBGene00018225</td><td>F40B5.1</td><td>nep-14</td><td>-6.0836</td>\n"
    html +="<tr><td>WBGene00004170</td><td>Y73F8A.8</td><td>pqn-90</td><td>-5.7193</td>\n"
    html +="<tr><td>WBGene00009104</td><td>F25C8.1</td><td>nan</td><td>-5.6225</td>\n"
    html +="<tr><td>WBGene00003462</td><td>F09C12.7</td><td>msp-74</td><td>-5.5895</td>\n"
    html +="<tr><td>WBGene00185117</td><td>C45B11.9</td><td>nan</td><td>-5.4953</td>\n"
    html +="</table>\n"
    html +="<br>\n"
    return html 

def add_data_image_div(base_dir,image):
    html = "<div>\n"
    html +="<table class='bordered-table styled-table'>\n"
    html +="    <tr><th colspan='2' style='text-align: center;border-bottom: 1px solid white;'>Execution Information</th></tr>\n"
    html +="    <tr><th>Name</th><th>Value</th></tr>\n"
    html +="    <tr><td>Dataset: </td><td>alldetected</td></tr>\n"
    html +="    <tr><td>Normalization:</td><td>MRN</td></tr>\n"
    html +="    <tr><td>DESeq2 Params:</td><td>fitType=parametric, betaPrior=FALSE, testType=LRT</td></tr>\n"
    html +="    <tr><td>Heatmap Params:</td><td>Scaled=TRUE, Centered=TRUE, Pseudo-count-0.01</td></tr>\n"
#    html +="    <tr><td>Condition 1:</td><td></td></tr>\n"
#    html +="    <tr><td>Condition 2:</td><td></td></tr>\n"
    html +="</table>\n"
    html += "<br>\n"
    html += f"\t<img src='{base_dir}/{image}' style='width: 65%;'>\n"
    html += "</div>"
    return html


def add_two_img_div(base_dir,image1,image2):
    html = "<div>\n"
    html += f"\t<img src='{base_dir}/{image1}' style='width: 48%;'>\n"
    html += f"\t<img src='{base_dir}/{image2}' style='width: 48%;'>\n"
    html += "</div>"
    return html



def generate_markdown(json_file):
    with open(REPORT_TEMPLATE_FILE, 'r') as file:
        report_template = file.read()

    report_data = {}
    report_data = add_title_page(json_file, report_data)
    report_data = add_low_counts_filter_table(report_data)
    report_data = add_deseq_run_details(report_data)

    markdown_content = report_template.format(title=report_data['title'],
                                              process_date=report_data['process_date'],
                                              prepared_by=report_data['prepared_by'],
                                              prepared_for=report_data['prepared_for'],
                                              low_counts_table=report_data['low_counts_table'],
                                              differential_results=report_data['differential_results'])
 
    

    # Write Markdown content to output file
    with open(DESEQ_REPORT_MD, 'w') as file:
        file.write(markdown_content)

    print("Markdown file generated successfully.")

def convert_to_html(markdown_file_name, css_file_name):
    with open(markdown_file_name, mode="r", encoding="utf-8") as markdown_file:
        with open(css_file_name, mode="r", encoding="utf-8") as css_file:
            markdown_input = markdown_file.read()
            css_input = css_file.read()

            markdown_path = os.path.dirname(markdown_file_name)
            markdown_include = MarkdownInclude(configs={"base_path": markdown_path})
            html = markdown.markdown(
                markdown_input, extensions=["extra", markdown_include, "meta", "tables"]
            )

            return f"""
            <html>
              <head>
                <style>{css_input}</style>
              </head>
              <body>{html}</body>
            </html>
            """

def convert_to_pdf(markdown_file_name, css_file_name):
    
    file_name = os.path.splitext(markdown_file_name)[0]
    html_string = convert_to_html(markdown_file_name, css_file_name)

    with open(
        file_name + ".html", "w", encoding="utf-8", errors="xmlcharrefreplace"
    ) as output_file:
        output_file.write(html_string)

    markdown_path = os.path.dirname(markdown_file_name)
    print(f"{os.path.splitext(markdown_file_name)=}\n{markdown_file_name=}\n{markdown_path=}")
    html = HTML(string=html_string, base_url=markdown_path)
    html.write_pdf(file_name + ".pdf")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--report-config', help='JSON Config file for report')
    parser.add_argument('-i', '--input-path', help='The input path for report data')
    args = parser.parse_args()
    cmd_line_msg = "deseq_report.py --report-config [<report.json>] --input-path [<base_directory>]"
        
    if not args.report_config:
        print(cmd_line_msg)
        print("JSON Config is missing.")
        return
    
    if not args.input_path:
         print(cmd_line_msg)
         print("Input path is missing.")
         return

    generate_markdown(args.report_config)
    convert_to_pdf(DESEQ_REPORT_MD, REPORT_TEMPLATE_CSS)

if __name__ == '__main__':
    main()

