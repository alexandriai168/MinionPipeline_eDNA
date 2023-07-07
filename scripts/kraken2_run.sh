

##### Classification
SEQPATH="/mnt/nfs/home/KellyCEG/aim/minion_project/clustered_seqs//mnt/nfs/home/KellyCEG/aim/minion_project"
kraken2 --db $DBNAME --threads 2 --report-zero-counts --output ${SAMPLENAME}.report.out --report ${SAMPLENAME}.report $SEQPATH/seqs.fa