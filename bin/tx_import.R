#!/usr/bin/env Rscript

library(tximport)
library(tidyverse)

samples <- list.files(path = "./results", full.names = T, pattern="salmon$")
files <- file.path(samples, "quant.sf")
names(files) <- str_replace(samples, "./results/", "") %>%
                str_replace("salmon_expression_", "")
tx2gene <- read.delim("tx2gene.tsv")

txi <- tximport(files, type="salmon", tx2gene=tx2gene[,c("tx_id", "ensgene")], countsFromAbundance="lengthScaledTPM")
#txi$counts %>% View()

counts_data <- txi$counts %>% 
  round() %>% 
  data.frame()

write.table(counts_data, file='counts.tsv', quote=FALSE, sep='\t')

abundance_data <- txi$abundance %>% 
  round() %>% 
  data.frame()

write.table(abundance_data, file='abundance.tsv', quote=FALSE, sep='\t')

length_data <- txi$length %>% 
  round() %>% 
  data.frame()

write.table(length_data, file='length.tsv', quote=FALSE, sep='\t')
