#!/usr/bin/env nextflow
nextflow.preview.dsl=2

process concat {
  //publishDir "${params.out_dir}/${samplename}", mode: 'copy'
  container params.sce.container
  input:
  file rdsfiles
  val samplename
  val concatname
  output:
  tuple val(samplename), file("${samplename}.SINGLE_CELL_EXPERIMENT__CONCATENATION.rds")
  script:
  """
  Rscript ${params.pdir}/processes/concatenation/concatenation.R --rdsFiles ${rdsfiles} --sampleNames "${samplename} \
  		--concatSampleName ${concatname}"
  """
}

workflow SINGLE_CELL_EXPERIMENT__CONCATENATION {
	take :
		data
	main :
		idListed = data.map{ id, file -> id }.toList().println()
		fileListed = data.map{ id, file -> file }.toList().println()
		concat(idListed,fileListed,params.concatenation.concatSampleName)
	emit:
		concat.out
}
