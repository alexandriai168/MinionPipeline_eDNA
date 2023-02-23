#!/bin/bash

DBNAME="/mnt/nfs/home/KellyCEG/aim/minion_project/kraken2_db/"

##### Download Taxonomy Database
kraken2-build --download-taxonomy --db $DBNAME

##### Use Esearch to batch download all 12s seqs from NCBI

esearch -db nucleotide -query "Chordata"[Organism] AND 12S[All Fields] NOT shotgun NOT predicted NOT uncultured NOT unclassified NOT pdb | efetch -format fasta >> miFish.fa

esearch -db nucleotide -query txid9312[organism:exp] AND 12S[All Fields] | efetch -format fasta >> kangaroo.fasta
#looks for the terms 12S and restricts it to chordata ()
#not shotgun, or predicted sequences, or uncultured or unclassified
# the error it gave me was: scan_fasta_file.pl: unable to determine taxonomy ID for sequence pdb|8CSR|A
#noticed that there's no kangaroo... which is bad bc kangaroo is chordata AND it does have 12S sequences

##### Add fasta files to db
kraken-build --add-to-library miFish.fa --db $DBNAME

##### build the kraken2 db
kraken2-build --build --db $DBNAME 








