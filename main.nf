#!/usr/bin/env nextflow
nextflow.preview.dsl=2

include { SINGLE_CELL_EXPERIMENT__SCE_BUILDER } from './processes/sceObjBuilder/sceBuilder.nf' params(params)
include { SINGLE_CELL_EXPERIMENT__FILTERING_EMPTYDROPLETS } from  './processes/filteringEmptyDroplets/filteringEmptyDroplets.nf' params(params)
include { SINGLE_CELL_EXPERIMENT__BC_RANK_METRICS } from  './processes/bcRankMetrics/bcRankMetrics.nf' params(params)
include { SINGLE_CELL_EXPERIMENT__FILTERING_THRESHOLDS } from  './processes/filteringThresholds/filteringThresholds.nf' params(params)
include { SINGLE_CELL_EXPERIMENT__CELL_QC_METRICS } from  './processes/cellQCMetrics/cellQCMetrics.nf' params(params)
include { SINGLE_CELL_EXPERIMENT__NORMALIZATION } from  './processes/normalization/normalization.nf' params(params)
include { SINGLE_CELL_EXPERIMENT__REPORT_GENERATOR } from  './processes/reportGenerator/reportGenerator.nf' params(params)
//include FILTERING from 'workflows/filtering.nf' params(params)
include { SINGLE_CELL_EXPERIMENT__PCA_FILTERING } from  './processes/pcaFiltering/pcaFiltering.nf' params(params)

workflow SCE_RNA {
	input = Channel.fromPath(params.sce.sceObjBuilder.inputFile)
					.map{ file -> tuple(params.global.sampleName,file)}
	SINGLE_CELL_EXPERIMENT__SCE_BUILDER(input)
	SINGLE_CELL_EXPERIMENT__BC_RANK_METRICS(SINGLE_CELL_EXPERIMENT__SCE_BUILDER.out)
	SINGLE_CELL_EXPERIMENT__FILTERING_EMPTYDROPLETS(SINGLE_CELL_EXPERIMENT__BC_RANK_METRICS.out)
	SINGLE_CELL_EXPERIMENT__CELL_QC_METRICS(SINGLE_CELL_EXPERIMENT__FILTERING_EMPTYDROPLETS.out)
	SINGLE_CELL_EXPERIMENT__FILTERING_THRESHOLDS(SINGLE_CELL_EXPERIMENT__CELL_QC_METRICS.out)
	SINGLE_CELL_EXPERIMENT__NORMALIZATION(SINGLE_CELL_EXPERIMENT__FILTERING_THRESHOLDS.out)
	SINGLE_CELL_EXPERIMENT__REPORT_GENERATOR(SINGLE_CELL_EXPERIMENT__NORMALIZATION.out)
}

workflow test {
	input = Channel.fromPath(params.sce.inputRdsFile)
					.map{ file -> tuple(params.global.sampleName,file)}
	SINGLE_CELL_EXPERIMENT__PCA_FILTERING(input)
	SINGLE_CELL_EXPERIMENT__NORMALIZATION(SINGLE_CELL_EXPERIMENT__PCA_FILTERING.out[0])

}
