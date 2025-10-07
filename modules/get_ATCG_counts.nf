process GET_ATCG_COUNTS {


    publishDir path: "${params.outdir}/ATCG", pattern: "*.csv"

    input:
    path(read)

    output:
    path("*.csv")
    path("*.txt"), emit: seq

    script:
    """
    ls $read > file
    while read line; do
        pair_id=\$(basename \$line _001.fastq.gz)
        zcat \$line | paste - - - - | cut -f2 | cut -c1-12 > \${pair_id}.txt
    done < file
    rm file

    get_ATCG_counts.py ${params.run}
    """
}
