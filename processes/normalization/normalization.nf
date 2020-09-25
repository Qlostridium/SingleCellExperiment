#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = (params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"

process SINGLE_CELL_EXPERIMENT__NORMALIZATION {
	//publishDir "${params.out_dir}/${samplename}", mode: 'copy'
	container params.sce.container
	input:
	tuple val(samplename), file(scerds)
	output:
	tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__NORMALIZATION.rds")
	script:
	def sampleParams = params.configParser(samplename, params.sce.normalization)
	"""
	Rscript ${scriptDir}/normalization/normalization.R --sceObj ${scerds} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__NORMALIZATION.rds" \
		${(sampleParams.quickCluster == null) ? '':"--quickCluster"} \
		${(sampleParams.useSumFactors == null) ? '':"--useSumFactors"}
	"""
}
