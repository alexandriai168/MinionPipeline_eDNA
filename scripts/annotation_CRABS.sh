# 1. db_download

## 1.3  mitofish
# downloading the mitofish database
crabs db_download --source mitofish --output mitofish.fasta --keep_original yes
# in order to get this to work, i needed to update the crabs executable AND the module_db_download.py 

## 1.5 taxonomy
# downloading taxonomy so you can assign taxonomic lineage
crabs db_download --source taxonomy
#outputs are: names.dmp nodes.dmp nucl_gb.accession2taxid

# skipped 2 and 3 because didn't import external databases or need to merge them

# 4. Extract amplicon sequences from downloaded reference database

## 4.1 insilico_pcr
crabs insilico_pcr --input mitofish.fasta --output insilico_database_output.fasta --fwd GCCGGTAAAACTCGTGCCAGC --rev CATAGTGGGGTATCTAATCCCAGTTTG --error 4.5
#kept default error of 4.5... feels like a lot, esp for cutadapt

## 4.2 pga
crabs pga --input mitofish.fasta --output pga_database_output.fasta --database insilico_database_output.fasta --fwd GCCGGTAAAACTCGTGCCAGC --rev CATAGTGGGGTATCTAATCCCAGTTTG --speed medium --percid 0.95 --coverage 0.95 --filter_method strict
### from the crabs github:
#--database is the database to be searched against is the output file from the in silico PCR 
#--input the originally downloaded database file

# 5. assign_tax
crabs assign_tax --input pga_database_output.fasta --output assigned_tax.tsv --acc2tax nucl_gb.accession2taxid --taxid nodes.dmp --name names.dmp --missing missing_taxa.tsv 

# 6. dereplicate
crabs dereplicate --input assigned_tax.tsv --output assigned_tax_derep.tsv --method uniq_species
#maybe go over which is the right choice for method!

# 7. Clean database using multiple parameters and exclusion filters
#idk! I think I'll just leave it as is- idk why we'd wanna do any of these except max or min length?
#would be good to go over choices with ppl

# 8. visualization
## 8.1. diversity
crabs visualization --method diversity --input assigned_tax_derep.tsv --level class

## 8.2. amplicon_length
crabs visualization --method amplicon_length --input assigned_tax_derep.tsv --level class

## 8.3. db_completeness
## 8.4. phylo
## 8.5 primer_efficiency
#didn't do this yet, but could be good if I'm interested in particular species

# 9. tax_format
crabs tax_format --input assigned_tax_derep.tsv --output final_reference_database.fasta --format dads
# this would be for dada2

