#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(DropletUtils))
suppressPackageStartupMessages(library(scMerge))
suppressPackageStartupMessages(library(Matrix))
suppressPackageStartupMessages(library(argparse))

parser <- ArgumentParser()
parser$add_argument("--rdsFiles", nargs='+', 
                    help="At least 2 rds files containing SCE object")
parser$add_argument("--sampleNames", 
                    help = "a list of sample names eg: [\"sample1\",\"sample2\",...]")
parser$add_argument("--output",
                    help = "")

opt <- parser$parse_args()
print(opt)

scelist <- list()
samplenames <- strsplit(gsub("\\[","",gsub("\\]",'',opt$sampleNames)),", ")[[1]]

for(i in 1:length(opt$rdsFiles)){
  scelist[[i]] <- readRDS(opt$rdsFiles[[i]])
  counts(scelist[[i]]) <- as.matrix(counts(scelist[[i]]))
}

csce <- sce_cbind(scelist, batch_names = samplenames, exprs = c("counts"), method = "union", cut_off_batch = 0, cut_off_overall = 0)
counts(csce) <- as(counts(csce), "dgTMatrix")
saveRDS(csce,file = opt$output)