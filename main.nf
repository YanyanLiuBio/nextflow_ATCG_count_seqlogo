nextflow.enable.dsl = 2

include { GET_ATCG_COUNTS } from './modules/GET_ATCG_COUNTS.nf'
include { SEQLOGO } from './modules/SEQLOGO.nf'

fq_ch = Channel
    .fromPath("${params.input}/*_R{1,2}_001.fastq.gz")
    .filter{it.baseName.contains("R1_001")} 


workflow {
    ATCG_OUT = GET_ATCG_COUNTS(fq_ch)
    SEQLOGO(ATCG_OUT.seq.collect())
}
