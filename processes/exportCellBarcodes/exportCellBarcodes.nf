#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = ( params.global.standAlone == null || params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"


process SINGLE_CELL_EXPERIMENT__EXPORT_CELLBARCODES {
  //publishDir "${params.ddir}/${samplename}", mode: 'copy'
  container params.sce.container
  input:
  tuple val(samplename), file(cmat)
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__EXPORT_CELLBARCODES.csv")
  script:
  """
  Rscript ${scriptDir}/exportCellBarcodes/exportCellBarcodes.R --rdsFile ${cmat} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__EXPORT_CELLBARCODES.csv"
  """
}
