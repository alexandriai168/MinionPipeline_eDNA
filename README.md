# Kelly Lab Minion Metabarcoding Data Pipeline 
## by: Alexandria Im

**This pipeline is still under construction! Check back for a finished product:)**

This repo contains code that the Kelly Lab uses to work with metabarcoding data that comes off of the Oxford Nanopore's Minion. 

This data pipeline has 4 steps:
 * *Concatenate Fastq Files* 
 * *Trim Primers*
 * *Cluster Sequences*
 * *Taxonomic Assignment*

## Concatenate Fastq Files
This step is done using the `cat_fastq.sh` script.

## Trim Primers
This step is done using the `cutadapt_minion.sh` script.

## Cluster Sequences
This step is done using the `cluster.sh` script.

## Taxonomic Assignment
This step is done using the `kraken2_database_build.sh` and `kraken2_run.sh` script.
