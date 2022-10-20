#!/usr/bin/env Rscript

library("optparse")
library("Biostrings")
library("ShortRead")

option_list <- list(
  make_option(c("-f", "--file"), type="character", default=NULL, 
              help="input fastq file name", metavar="character"),
  make_option(c("-l", "--length"), type="integer", default=NULL, 
              help="number of bases to trim to", metavar="number"),
  make_option(c("-q", "--qualscore"), type="integer", default=NULL, 
              help="quality score to filter to", metavar="number"),
  make_option(c("-m", "--min_length"), type="integer", default=NULL, 
              help="minimum sequence length to filter by", metavar="number"),
  make_option(c("-o", "--out"), type="character", default="out_trimmed.fasta", 
              help="output file name [default= %default]", metavar="character")
); 

opt_parser <- OptionParser(option_list=option_list);
opt <- parse_args(opt_parser);


if (is.null(opt$file)){
  print_help(opt_parser)
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

if (is.null(opt$length)){
  print_help(opt_parser)
  stop("No argument supplied to --length (-l) with no default.", call.=FALSE)
}

if (is.null(opt$qualscore)){
  print_help(opt_parser)
  warning("No argument supplied to --min_length (-m) with no default. Will not filter by minimum length.", call.=FALSE)
} 

message(paste("\nStarting to trim and filter",opt$file,"at",Sys.time(),"\n"), appendLF = TRUE)
testfastq <- opt$file

test <- readDNAStringSet(testfastq, format="fastq", with.qualities=TRUE)

# idk whats happening here lmao 
quals <- PhredQuality(mcols(test)$qualities)
QualityScaledDNAStringSet(test, quals)

# keep only seqs that are longer than minimum length (given that -m arg is supplied)
if(!is.null(opt$qualscore)){
  test <- test[nchar(test)>opt$qualscore]
}

# trim anything longer than desired length 
test170 <- subseq(test, start = 1, end = opt$length)

# write to fasta 
newfasta <- opt$out
writeXStringSet(test170, newfasta, format="fasta")

message(paste("\nFinished trimming and filtering",opt$file,"at",Sys.time(),"\n"), appendLF = TRUE)

