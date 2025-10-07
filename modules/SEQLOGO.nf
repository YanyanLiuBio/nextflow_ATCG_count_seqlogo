process SEQLOGO {

    publishDir path: "${params.outdir}/ATCG/logoplot_from_fq/", mode: 'copy'

    input:
    path(seq_combined)

    output:
    path("*.png")

    script:
    """
    seqlogo.R
    """
}
