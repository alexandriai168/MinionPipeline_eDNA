#!/bin/bash

# CLUSTERING SCRIPT FOR MINION DATA
# by: Alexandria Im

# USAGE: cluster.sh {path to input fastas} {output fasta name} {path for output}

# inspo for this script was taken from this tutorial:
# https://github.com/frederic-mahe/swarm/wiki/Fred's-metabarcoding-pipeline (thanks Fred)
# this script requires that you have seqkit, vsearch, and swarm
# seqkit: https://bioinf.shenwei.me/seqkit/
# vsearch: https://github.com/torognes/vsearch
# swarm: https://github.com/torognes/swarm

#################################### STEP 0: SET VARIABLES AND CHECK DEPENDENCIES ####################################
# checking packages
# this for loop checks if your command is found and if not, asks if you want to install it.
for i in seqkit vsearch swarm 
do
if ! which ${i} > /dev/null; then
echo "${i} command not found! Install? (y/n) \c"
read
if "$REPLY" = "y"; then
    pip install ${i}
fi
fi
done

# set variables
SEQKIT=$(which seqkit)
VSEARCH=$(which vsearch)
SWARM=$(which swarm)
INPUT_FASTA=${1}
FINAL_FASTA=${2}
OUTPUT_PATH=${3}
cd ${OUTPUT_PATH}
echo  "The input fasta is:" ${INPUT_FASTA}" \n"
echo  "The output name is:" ${FINAL_FASTA}" \n"
echo  "The output directory is:" $(pwd) " \n"
mkdir ${OUTPUT_PATH}/derep
mkdir ${OUTPUT_PATH}/linearization
mkdir ${OUTPUT_PATH}/clustering
sleep 5

#################################### STEP 1: FASTQ TO FASTA ####################################
echo "Converting fastq's to fasta's... \n"
sleep 5
${SEQKIT} fq2fa ${INPUT_FASTA} -o to_derep.fasta
echo "Finished conversion. \n"
sleep 5

#################################### STEP 2: DEREPLICATION ####################################
echo "Starting dereplication... \n"
sleep 5
"${VSEARCH}" \
    --derep_fulllength to_derep.fasta \
    --sizein \
    --sizeout \
    --fasta_width 0 \
    --relabel_sha1 \
    --output ${OUTPUT_PATH}/derep/to_cluster.fasta 2>> ${OUTPUT_PATH}/derep/dereplication.log

rm to_derep.fasta
echo "Finished dereplication. \n"
sleep 5

#################################### STEP 3: LINEARIZATION ####################################
echo "Starting linearization... \n"
sleep 5
${SEQKIT} seq -w 0 ${OUTPUT_PATH}/derep/to_cluster.fasta > ${OUTPUT_PATH}/linearization/lin.log
echo "Finished linearization. \n"
sleep 5

#################################### STEP 4: CLUSTERING ####################################
echo "Starting clustering... \n"
#THREADS=16
${SWARM} \
    -d 1 -f -z \
    -b 5 \
    -s ${OUTPUT_PATH}/clustering/swarm.stats \
    -l ${OUTPUT_PATH}/clustering/swarm.log \
    -w ${OUTPUT_PATH}/clustering/swarm.fasta \
    -o ${OUTPUT_PATH}/clustering/${FINAL_FASTA}.swarms < ${OUTPUT_PATH}/derep/to_cluster.fasta 
echo "Finished clustering. \n"
rm ${OUTPUT_PATH}/derep/to_cluster.fasta

