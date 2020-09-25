#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = ( params.global.standAlone == null || params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"

process SINGLE_CELL_EXPERIMENT__REPORT_GENERATOR {
	publishDir "${params.outDir}/${sampleid}", mode: 'move', pattern: "${sampleid}_report.html"
	container params.sce.container
	input:
	tuple val(sampleid), file(rdsfile)
	output:
	file("${sampleid}_report.html")
	script:
	"""
	cp -L ${params.pdir}/processes/reportGenerator/reportGenerator.Rmd report.Rmd
	cp -L ${rdsfile} final.rds
	R -e 'rmarkdown::render("report.Rmd",output_file = "${sampleid}_report.html",params = list(input="final.rds",id="${sampleid}"))'
	rm report.Rmd final.rds
	"""
}
