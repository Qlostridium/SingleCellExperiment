# Barcode Rank Metrics module

### Input :  
A nextflow tuple, with a sample name and a rds file containing a SingleCellExperiment (SCE) object.

### Description :  
Compute barcode rank statistics and identify the knee and inflection points on the total count curve. The statistics and the graphs generated are stored in the SCE object's metadata.

### Output :  
A nextflow tuple, with a sample name and a rds file containing SCE object.
