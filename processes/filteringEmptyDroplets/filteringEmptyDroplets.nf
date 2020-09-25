#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = ( params.global.standAlone == null || params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"

process SINGLE_CELL_EXPERIMENT__FILTERING_EMPTYDROPLETS {
  //publishDir "${params.ddir}/${samplename}", mode: 'copy'
  container params.sce.container
  input:
  tuple val(samplename), file(cmat)
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__FILTERING_EMPTYDROPLETS.rds")
  script:
  def sampleParams = params.configParser(samplename, params.sce.filteringEmptyDroplets)
  """
  Rscript ${params.pdir}/processes/filteringEmptyDroplets/filteringEmptyDroplets.R --rdsFile ${cmat} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__FILTERING_EMPTYDROPLETS.rds" \
		${(!(sampleParams.fdrThreshold == null)) ? '--fdr-threshold ' + sampleParams.fdrThreshold: ''} \
		${(!(sampleParams.nbUMILowerBound == null)) ? '--lower ' + sampleParams.nbUMILowerBound: ''}
  """
}
