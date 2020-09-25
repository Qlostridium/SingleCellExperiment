#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = ( params.global.standAlone == null || params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"


process SINGLE_CELL_EXPERIMENT__BC_RANK_METRICS {
  //publishDir "${params.ddir}/${samplename}", mode: 'copy'
  container params.sce.container
  input:
  tuple val(samplename), file(rdsfile)
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__BC_RANK_METRICS.rds")
  script:
  """
  Rscript ${scriptDir}/bcRankMetrics/bcRankMetrics.R --rdsFile ${rdsfile} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__BC_RANK_METRICS.rds"
  """
}
