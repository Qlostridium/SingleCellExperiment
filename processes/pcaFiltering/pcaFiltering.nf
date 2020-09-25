#!/usr/bin/env nextflow
nextflow.preview.dsl=2
scriptDir = (params.global.standAlone != true) ? "${params.global.rundir}/src/SingleCellExperiment/processes" : "${params.global.rundir}/processes"

process SINGLE_CELL_EXPERIMENT__PCA_FILTERING {
  publishDir "${params.global.outdir}/${samplename}", mode: 'symlink', pattern:"Plots/RNA/**"
  container params.sce.container
  input:
  tuple val(samplename), file(scerds)
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__PCA_FILTERING.rds")
  file("Plots/RNA/**")
  script:
  def sampleParams = params.configParser(samplename, params.sce.pcaFiltering)
  """
  Rscript ${scriptDir}/pcaFiltering/pcaFiltering.R --sceObj ${scerds} \
		--output "${samplename}.SINGLE_CELL_EXPERIMENT__PCA_FILTERING.rds" \
		--scriptFunctions ${scriptDir}/utils/script_functions_BioIT.R \
		${(!(sampleParams.removeOutliers == null)) ? '--removeOutliers': ''}
  """
}
