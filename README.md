# Unix and work with genomic data 
## Excercise 3
### Distribution of PHRED qualities INDELS vs. SNPs


**1. príprava**

*cd projects*

*mkdir fin_ex*

*cd fin_ex*

*mkdir data*

*cp -T /data-shared/vcf_examples/luscinia_vars.vcf.gz ~/projects/fin_ex/data/luscinia_vars.vcf.gz

gunzip /data/luscinia_vars.vcf.gz*


**2. filtrovanie**
> workflow.sh

	# odstranenie "#" riadkov 
	
*grep -v -E ^# luscinia_vars.vcf* 
	# kontrola grep -v -E ^# data/luscinia_vars.vcf | cut -f1 | sort | uniq -c 
	# potrebne odfiltrovanie

 *grep -v -E ^# data/luscinia_vars.vcf | grep -e 'chr1\s' -e 'chr1A\s' -e 'chr1B\s' -e 'chr2\s' -e 'chr3\s' -e 'chr4\s' -e 'chr4A\s' -e 'chr5\s' -e 'chr6\s' -e 'chr7\s' -e 'chr8\s' -e 'chr9\s' -e 'chr10\s' -e 'chr11\s' -e 'chr12\s' -e 'chr13\s' -e 'chr14\s' -e 'chr15\s' -e 'chr16\s' -e 'chr17\s' -e 'chr18\s' -e 'chr19\s' -e 'chr20\s' -e 'chr21\s' -e 'chr22\s' -e 'chr23\s' -e 'chr24\s' -e 'chr25\s' -e 'chr26\s' -e 'chr27\s' -e 'chr28\s' -e 'chrAmb\s' -e 'chrZ\s' -e 'chrLG2\s' -e 'chrLG5\s' -e 'chrLGE22\s' -e 'chrM'> data/luscinia_vars_filtred.vcf*
 
 	# vyhodene *_random, chrUn, chrUnmapped

**3. tvorba tabuľky**
> workflow.sh

*cut -f1,6,8 data/luscinia_vars_filtred.vcf | awk '($3 ~/^INDEL/) {print $1, $2,"\tINDEL"}' | sed -r 's/\s/\t/' > data/luscinia_vars_filtred_indel.tsv*

*cut -f1,6,8 data/luscinia_vars_filtred.vcf | awk '($3 ~/^DP/) {print $1, $2,"\tSNP"}' | sed -r 's/\s/\t/' > data/luscinia_vars_filtred_snp.tsv*

	# cut vyhodi nepotrebne data
	# awk najde frazu a yanecha iba potrebne data
	# sed zmena medzeri na tab pre .tsv subor
	# je to trochu škaredé ale funguje to

*cat data/*.tsv > data/luscinia_vars_final.tsv*
	# spojenie dat pre R
	
**4. R plot**
>plot.r

*library(tidyverse)*

*library(ggplot2)*

*setwd ('~/projects/fin_ex/')*

*read_tsv('data/luscinia_vars_final.tsv',  col_names=c("CHROMOSOME", "QUALITY", "INDELS_vs_SNPs")) -> plot*


*plot %>%*
  
  *ggplot(aes(INDELS_vs_SNPs, QUALITY)) +
  geom_boxplot(outlier.colour = NA, fill = "grey") +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5)) +
  scale_y_log10()*
  
  ### Graf
  ![plot](https://github.com/RekValT/Distribution-of-PHRED-qualities-INDELS-vs.-SNPs/blob/master/results/plot.png)
