/*
 * Quality control of the reads
 */
process FASTQC {
    tag "FASTQC on $sample_id"

    container "quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0"

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple path("fastqc_logs/*.html"), path("fastqc_logs/*.zip")

    script:
    """
    mkdir fastqc_logs
    fastqc -o fastqc_logs -t $task.cpus $reads
    """
}

process MULTIQC {
    publishDir params.outdir, mode:'copy'

    container "quay.io/biocontainers/multiqc:1.19--pyhdfd78af_0"

    input:
    path '*'

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc .
    """
}