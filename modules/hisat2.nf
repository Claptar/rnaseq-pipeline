/*
 * Use hisat2 to quantify gene expression
 */
process INDEX {
    container 'quay.io/biocontainers/hisat2:2.2.1--hdbdd923_6'

    input:
    path genome

    output:
    tuple val("hisat_index"), path('hisat_index*')

    script:
    """
    hisat2-build -p $task.cpus $genome hisat_index
    """
}

process QUANTIFY {
    tag "HISAT2 on $sample_id"
    publishDir "$params.outdir/hisat_output/sam", pattern: "*.sam", mode: 'copy'
    publishDir "$params.outdir/hisat_output/summary", pattern: "*.txt", mode: 'copy'
    container 'quay.io/biocontainers/hisat2:2.2.1--hdbdd923_6'

    input:
    tuple val(sample_id), path(reads)
    tuple val(hisat_index), path('*')
    path gtf
    
    output:
    tuple val(sample_id), path("*.sam"), emit: sam
    path "*.txt", emit: summary

    script:
    """
    hisat2 -p $task.cpus --phred33 -x $hisat_index -U $reads -S ${sample_id}.sam --summary-file ${sample_id}_summary.txt
    """
}


process SAM2BAM {
    tag "SAM2BAM on $sample_id"
    publishDir "$params.outdir/hisat_output/bam", mode: 'copy'
    container 'quay.io/biocontainers/samtools:1.19.2--h50ea8bc_0'

    input:
    tuple val(sample_id), path(sam)
    
    output:
    tuple val(sample_id), path("*_sorted.bam"), emit: bam
    path "*.bai", emit: index

    script:
    """
    # convert sam -> bam, sort and index
    samtools view -@ $task.cpus -bS $sam > ${sample_id}.bam
    samtools sort ${sample_id}.bam -o ${sample_id}_sorted.bam -@ $task.cpus
    samtools index ${sample_id}_sorted.bam -@ $task.cpus
    """
}