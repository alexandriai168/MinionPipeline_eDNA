#!/bin/bash

# for i in # of barcodes
# this should be run in the command line
# make directory called concat_files before running
# run from directory containing all barcode directories
for name in *barcode* 
do
echo starting $name
cd $name #cd into each barcode
cat * > $name.fastq.gz #cat all the fastqs and pipe into a new file located in the concat_files directory
mv $name.fastq.gz ../../cat_pass #move to cat_pass folder
cd .. 
echo finished $name #lets you know your progress
done

#remember to add line that echos # of fastq's in the directory
#remember to add the time that it takes to cat the files
