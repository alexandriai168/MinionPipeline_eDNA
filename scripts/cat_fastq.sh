#!/bin/bash

# CONCATENATE FASTQ'S SCRIPT FOR MINION DATA
# by: Alexandria Im
# Nov 2022

# for i in # of barcodes
# this should be run in the command line
# make directory called concat_files before running
# run from directory containing all barcode directories
for name in *barcode* 
do
echo starting $name
cd $name #cd into each barcode

##### add # of files in each barcode to log file #####
echo "the number of files in $name is:"
ls | wc -l
echo "the number of files in $name is:" > cat_fastq.log 
ls | wc -l >> cat_fastq.log 

cat * > $name.fastq.gz #cat all the fastqs and pipe into a new file located in the concat_files directory

##### add final file size to log file #####
echo "concatenated fastq size:"
ls -l $name.fastq.gz
echo "$name concatenated fastq size:" >> cat_fastq.log 
ls -l $name.fastq.gz >> cat_fastq.log


mv $name.fastq.gz ../../cat_pass #move to cat_pass folder
cd .. 

echo finished $name #lets you know your progress
done

