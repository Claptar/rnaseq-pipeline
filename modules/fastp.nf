/*
 * Trimming with fastp
 */

process FASTP {
    tag "FASTP on $sample_id"
    publishDir "${params.outdir}/trimmed_reads", pattern: '*_trimmed.fastq.gz', mode: 'copy'
    container "quay.io/biocontainers/fastp:0.23.4--hadf994f_2"

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val("${sample_id}_trimmed"), path("*_trimmed.fastq.gz"), emit: reads
    path "*.json", emit: json

    script:
    """
    fastp -i $reads -o ${sample_id}_trimmed.fastq.gz --average_qual 20 -j ${sample_id}_fastp.json -w $task.cpus
    """
}