library(tidyverse)
library(ggplot2)

setwd ('~/projects/fin_ex/')

read_tsv('data/luscinia_vars_final.tsv',  col_names=c("CHROMOSOME", "QUALITY", "INDELS_vs_SNPs")) -> plot


plot %>%
  
  ggplot(aes(INDELS_vs_SNPs, QUALITY)) +
  geom_boxplot(outlier.colour = NA, fill = "grey") +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5)) +
  scale_y_log10()