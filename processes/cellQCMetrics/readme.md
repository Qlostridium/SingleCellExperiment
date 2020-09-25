# Cell Quality Control Metrics module

### Input :  
A nextflow tuple, with a sample name and a rds file containing a SingleCellExperiment (SCE) object.  

#### optional parameters :  
- useMitochondrialGenes : set to "null" to ignore the mitochondrial genes.

### Description :  
Compute cell QC statistics in the counts assay. Add the statistics and the graphs generated in the SCE object's metadata.

### Output :  
A nextflow tuple, with a sample name and a rds file containing SCE object.
