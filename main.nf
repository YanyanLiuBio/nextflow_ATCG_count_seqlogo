nextflow.enable.dsl = 2

fq_ch = Channel
    .fromPath("${params.input}/*_R{1,2}_001.fastq.gz")


include { GET_ATCG_COUNTS } from './modules/GET_ATCG_COUNTS.nf'
include { SEQLOGO } from './modules/SEQLOGO.nf'

workflow {
    ATCG_OUT = GET_ATCG_COUNTS(fq_ch)
    SEQLOGO(ATCG_OUT.seq.collect())
}
