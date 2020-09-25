#!/usr/bin/env nextflow
nextflow.preview.dsl=2

scriptDir = ( params.global.standAlone == null || params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"

process SINGLE_CELL_EXPERIMENT__CELL_QC_METRICS {
  //publishDir "${params.out_dir}/${samplename}", mode: 'copy'
  container params.sce.container
  input:
  tuple val(samplename), file(scerds)
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__CELL_QC_METRICS.rds")
  script:
  def sampleParams = params.configParser(samplename, params.sce.cellQCMetrics)
  """
  Rscript ${scriptDir}/cellQCMetrics/cellQCMetrics.R --rdsFile ${scerds} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__CELL_QC_METRICS.rds" \
		${(!(sampleParams.useMitochondrialGenes == null)) ? '--mito': ''}
  """
}
