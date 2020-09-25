#!/usr/bin/env nextflow
nextflow.preview.dsl=2

// Include processes
include SINGLE_CELL_EXPERIMENT__EMPTYDROPLETS from '../processes/emptyDroplets/emptyDroplets.nf' params(params)
include SINGLE_CELL_EXPERIMENT__OUTLIERS_DETECTION from '../processes/outliersDetection/outliersDetection.nf' params(params)

workflow FILTERING_CELLS {
	take:
		data
	main:
	 	SINGLE_CELL_EXPERIMENT__EMPTYDROPLETS(data)
		SINGLE_CELL_EXPERIMENT__OUTLIERS_DETECTION(SINGLE_CELL_EXPERIMENT__EMPTYDROPLETS.out)
	emit:
		SINGLE_CELL_EXPERIMENT__OUTLIERS_DETECTION.out
}
