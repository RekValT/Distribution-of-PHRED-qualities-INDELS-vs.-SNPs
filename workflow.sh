#!/bin/bash
grep -v -E ^# data/luscinia_vars.vcf | grep -e 'chr1\s' -e 'chr1A\s' -e 'chr1B\s' -e 'chr2\s' -e 'chr3\s' -e 'chr4\s' -e 'chr4A\s' -e 'chr5\s' -e 'chr6\s' -e 'chr7\s' -e 'chr8\s' -e 'chr9\s' -e 'chr10\s' -e 'chr11\s' -e 'chr12\s' -e 'chr13\s' -e 'chr14\s' -e 'chr15\s' -e 'chr16\s' -e 'chr17\s' -e 'chr18\s' -e 'chr19\s' -e 'chr20\s' -e 'chr21\s' -e 'chr22\s' -e 'chr23\s' -e 'chr24\s' -e 'chr25\s' -e 'chr26\s' -e 'chr27\s' -e 'chr28\s' -e 'chrAmb\s' -e 'chrZ\s' -e 'chrLG2\s' -e 'chrLG5\s' -e 'chrLGE22\s' -e 'chrM'> data/luscinia_vars_filtred.vcf
cut -f1,6,8 data/luscinia_vars_filtred.vcf | awk '($3 ~/^INDEL/) {print $1, $2,"\tINDEL"}' | sed -r 's/\s/\t/' > data/luscinia_vars_filtred_indel.tsv
cut -f1,6,8 data/luscinia_vars_filtred.vcf | awk '($3 ~/^DP/) {print $1, $2,"\tSNP"}' | sed -r 's/\s/\t/' > data/luscinia_vars_filtred_snp.tsv
cat data/*.tsv > data/luscinia_vars_final.tsv
