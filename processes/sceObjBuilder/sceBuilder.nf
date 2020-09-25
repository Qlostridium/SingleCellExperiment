#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = ( params.global.standAlone == null || params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"

process SINGLE_CELL_EXPERIMENT__SCE_BUILDER {
  //publishDir "${params.ddir}/${samplename}", mode: 'copy'
  container params.sce.container
  input:
  tuple val(samplename), val(cmat)
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__SCE_BUILDER.rds")
  script:
  """
  Rscript ${params.pdir}/processes/sceObjBuilder/sceBuilder.R --inputMatrix ${cmat} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__SCE_BUILDER.rds"
  """
}
