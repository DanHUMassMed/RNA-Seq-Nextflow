#!/usr/bin/env Rscript

suppressPackageStartupMessages({}
    library(tximport)
    library(argparse)
    library(tidyverse)
})

#counts_method="lengthScaledTPM"
run_tximport <- function(input_path, output_path, tx2gene, counts_method) {  
    samples <- list.files(path = input_path, full.names = T, pattern="^salmon_expression")
    files <- file.path(samples, "quant.sf")
    names(files) <- str_replace(samples, "./results/", "") %>%
                    str_replace("salmon_expression_", "")
    tx2gene <- read.delim(tx2gene)

    txi <- tximport(files, type= "salmon", tx2gene= tx2gene, countsFromAbundance = counts_method)

    counts_data <- txi$counts %>% round() %>% data.frame()

    write.table(counts_data, file='counts.tsv', quote=FALSE, sep='\t')

    abundance_data <- txi$abundance %>% round() %>% data.frame()
    write.table(abundance_data, file=sprintf("%s/%s_abundance.tsv", output_path, tolower(myString))'', quote=FALSE, sep='\t')

    length_data <- txi$length %>%  round() %>% data.frame()

    write.table(length_data, file='length.tsv', quote=FALSE, sep='\t')
}
main <- function() {
      parser <- ArgumentParser()
      parser$add_argument("-f", "--file", help="File to be processed")
      parser$add_argument("-t", "--title", default="rgs", help="Title for the graph")
      parser$add_argument("-o", "--out_dir", default="./worm_cat_output", help="The output directory")

      parser$add_argument("-i", "--input_type", default="Sequence ID",
          help="Provide the Input type {'Sequence.ID', 'Wormbase.ID'} [default]")

      parser$add_argument("-r", "--rm_dir", default=TRUE,
          help="Remove temp directory [default]")

      args <- parser$parse_args()

      if (is.null(args$file)){
        stop("At least one argument must be supplied (input file).n", call.=FALSE)
      }

      print(paste("worm_cat_fun", args$file, args$title, args$out_dir, args$rm_dir, args$annotation_file, args$input_type))
      worm_cat_fun(
          file_to_process=args$file,
          title=args$title,
          output_dir=args$out_dir,
          rm_dir=args$rm_dir,
          annotation_file=args$annotation_file,
          input_type=args$input_type
      )

}

main()

