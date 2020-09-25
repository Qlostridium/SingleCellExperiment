#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = ( params.global.standAlone == null || params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"

process SINGLE_CELL_EXPERIMENT__FILTERING_THRESHOLDS {
  //publishDir "${params.ddir}/${samplename}", mode: 'copy'
  container params.sce.container
  input:
  tuple val(samplename), file(scerds)
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__FILTERING_THRESHOLDS.rds")
  script:
  def sampleParams = params.configParser(samplename, params.sce.filteringThresholds)
  """
  Rscript ${scriptDir}/filteringThresholds/filteringThresholds.R --rdsFile ${scerds} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__FILTERING_THRESHOLDS.rds" \
		${(!(sampleParams.nbMADs == null)) ? '--nmads ' + sampleParams.nbMADs: ''} \
		${(!(sampleParams.useMitochondrialGenes == null)) ? '--mito': ''}
  """
}
