#!/bin/bash


# this is a script that will use cutadapt to trim sequences for all barcodes
# before you run this script, make sure there is a directory with all fastq files 
# and set up directory to store output files + directory for reports

#  NOTE: THIS SCRIPT IS HARD CODED TO HAVE ERROR 40% AND MOVE INTO SET DIRECTORY.  WILL EDIT TO BE MORE CUSTOMIZABLE



for name in *barcode* 
do
echo trimming $name
cutadapt -a TTTCTGTTGGTGCTGATATTGCGCCGGTAAAACTCGTGCCAGC...ACTTGCCTGTCGCTCTATCTTCCATAGTGGGGTATCTAATCCCAGTTTG -e 0.4 $name.fastq.gz > ${name}_trimmed.fastq 2 > ${name}_trimReport.txt
# awk command that prints mean length 
echo $name > meanLength.txt 
awk '{if(NR%4==2) {count++; bases += length} } END{print bases/count}' ${name}_trimmed.fastq > meanLength.txt #fastq file
mv ${name}_trimmed.fastq ../trimmed_fastqs #move trimmed file into trimmed_fastq directory
echo finished $name #lets you know your progress
done




# look into % of reads that assign to kangaroo



