#!/bin/bash

# PRIMER TRIMMING SCRIPT FOR MINION DATA
# by: Alexandria Im
# Dec 2022

# This is a script that will use cutadapt to trim sequences for all barcodes in a particular directory
# USAGE: sh cutadapt_minion.sh {path to input fastas} {cutadapt max error rate} {primers to trim}
# for input 3, if you input "mifish", it will automically trim off mifish primers

# this script requires that you have cutadapt installed
# cutadapt: https://cutadapt.readthedocs.io/en/stable/ 



#################################### CHECK DEPENDENCIES ####################################
# check if cutadapt is installed
if ! which cutadapt > /dev/null; then
echo "Cutadapt not found! Install? (y/n) \c"
read
if "$REPLY" = "y"; then
    conda create -n cutadaptenv cutadapt
    conda activate cutadaptenv
fi
fi
CUTADAPT=$(which cutadapt)
# if you're having an issue with the above command, you may not have CONDA installed:
# https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html
# or you can explore other ways to install cutadapt:
# https://cutadapt.readthedocs.io/en/stable/installation.html


#################################### CHECKING INPUTS AND DEFINING VARIABLES ####################################
# defining variables and creating log directory

# define fastq path
if [ -z ${1} ]
then
    echo "no fastq path input"
else
    FASTQ_PATH=${1}
fi
cd ${FASTQ_PATH}

#make necassary directories
mkdir ../trimmed_fastqs
mkdir ../trimmed_fastqs/reports
TRIMMED_DIR=../trimmed_fastqs
REPORT_DIR=../trimmed_fastqs/reports

#define error variable
if [ -z ${2} ]
then
    ERROR_INPUT=0.4
else 
    ERROR_INPUT=${2}
fi

#define primer variable based on input
if [ ${3} = "mifish" ]
then
    echo "The primer input is Mifish. Cutadapt input is now TTTCTGTTGGTGCTGATATTGCGCCGGTAAAACTCGTGCCAGC...ACTTGCCTGTCGCTCTATCTTCCATAGTGGGGTATCTAATCCCAGTTTG \n"
    PRIMERS="TTTCTGTTGGTGCTGATATTGCGCCGGTAAAACTCGTGCCAGC...ACTTGCCTGTCGCTCTATCTTCCATAGTGGGGTATCTAATCCCAGTTTG"
elif [ -z ${3} ]
then
    echo "No primer input!"
else 
    PRIMERS=${3}
fi

sleep 5

#################################### USE CUTADAPT TO TRIM PRIMERS ####################################
for name in *barcode* 
do
echo "trimming $name..."
${CUTADAPT} -a ${PRIMERS} -e ${ERROR_INPUT} ${name} > trimmed_${name} 2> ${REPORT_DIR}/${name}_trim_report.txt
# awk command that prints mean length 
echo ${name} > ${TRIMMED_DIR}/meanLength.txt 
awk '{if(NR%4==2) {count++; bases += length} } END{print bases/count}' trimmed_${name} > ${TRIMMED_DIR}/meanLength.txt 
mv trimmed_${name} ${TRIMMED_DIR} #move trimmed file into trimmed_fastq directory
echo finished ${name} #lets you know your progress
done
