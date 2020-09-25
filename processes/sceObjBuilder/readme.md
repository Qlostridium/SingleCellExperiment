# SingleCellExperiment object builder module

### Input :  
A nextflow tuple, with a sample name and a path to a count matrix. accepted formats :  
- h5 file (eg :"/home/experiment/raw_bc_feature_matrix.h5")
- Cellranger v2 format ,e.g :  
```
raw_gene_bc_matrices
  ├── barcodes.tsv
  ├── genes.tsv
  └── matrix.mtx
```
- Cellranger v3 format, e.g :
```
raw_feature_bc_matrix
  ├── barcodes.tsv.gz
  ├── features.tsv.gz
  └── matrix.mtx.gz
```
- Starsolo format, e.g :
```
raw
  ├── barcodes.tsv
  ├── features.tsv
  └── matrix.mtx

```

### Description :  
Create a SingleCellExperiment object from the count matrix, select the Gene Expression data and make feature names unique.

### Output :  
A nextflow tuple, with a sample name and a rds file containing a SCE object.
