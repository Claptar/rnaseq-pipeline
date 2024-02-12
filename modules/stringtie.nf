/*
 * Counting reads
 */

process QUANTIFY {
    tag "Stringtie on $sample_id"
    publishDir "$params.outdir/kallisto_output", mode: 'copy'
    container 'quay.io/biocontainers/kallisto:0.48.0--h15996b6_2'

    input:
    tuple val(sample_id), path(bam)
    path kallisto_index
    
    output:
    path "$sample_id"

    script:
    """
    kallisto quant -i $kallisto_index -o $sample_id --single -l 100 -s 1 -t $task.cpus -b 100 $reads
    """
}