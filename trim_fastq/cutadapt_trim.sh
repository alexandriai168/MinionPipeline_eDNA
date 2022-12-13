#!/bin/bash


## example code for how to use cutadapt
# cutadapt -a TTTCTGTTGGTGCTGATATTGCGCCGGTAAAACTCGTGCCAGC...ACTTGCCTGTCGCTCTATCTTCCATAGTGGGGTATCTAATCCCAGTTTG -e 0.4 barcode2.fastq.gz > barcode3_trimmed.fastq.gz 2>report_barcode2.txt


## used this to show avg barcode length
# awk '{if(NR%4==2) {count++; bases += length} } END{print bases/count}' barcode3_trimmed.fastq.gz
# something to note is that the avg red length for untrimmed was ~130 and was 190 after... maybe consider filtering on size as well








