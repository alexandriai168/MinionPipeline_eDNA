install.packages(devtools)
devtools::install_github("LunaGal/rCRUX", build_vignettes = TRUE)
library(rCRUX)

# download taxids using taxonomizr 
library(taxonomizr)

accession_taxa_sql_path <- "/my/accessionTaxa.sql" #replace with path to where you want to store your taxid database
prepareDatabase(accession_taxa_sql_path)

