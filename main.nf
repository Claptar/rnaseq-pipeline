/*
include {INDEX as INDEX INDEX_KALLISTO} from './modules/kallisto.nf'
Channel.fromPath(params.reads).map { file -> [ file.name.take(file.name.indexOf('.')), file ] }.view()
*/
include {FASTQC} from "./modules/quality_control.nf"
include {MULTIQC} from "./modules/quality_control.nf"
include {FASTP} from "./modules/fastp.nf"
include {INDEX as KALLISTO_INDEX} from "./modules/kallisto.nf"
include {QUANTIFY as KALLISTO_QUANTIFY_RAW} from "./modules/kallisto.nf"
include {QUANTIFY as KALLISTO_QUANTIFY_TRIMMED} from "./modules/kallisto.nf"
include {INDEX as INDEX_HISAT} from "./modules/hisat2.nf"
include {QUANTIFY as HISAT_QUANTIFY_RAW} from "./modules/hisat2.nf"
include {QUANTIFY as HISAT_QUANTIFY_TRIMMED} from "./modules/hisat2.nf"
include {SAM2BAM as SAM2BAM_RAW} from "./modules/hisat2.nf"
include {SAM2BAM as SAM2BAM_TRIMMED} from "./modules/hisat2.nf"

workflow {
    // load reads to Channel
    reads_ch = Channel.fromPath(params.reads).map { file -> [ file.name.take(file.name.indexOf('.')), file ] }

    // run fastqc and fastp for raw reads
    fastqc_ch = FASTQC(reads_ch) 
    fastp_ch = FASTP(reads_ch)

    // run multiqc for fastqc and fastp output
    MULTIQC(fastqc_ch.mix(fastp_ch.json).collect())

    // calculate index for kallisto
    kallisto_index = KALLISTO_INDEX(params.transcriptome)

    // quantify raw reads and trimmed reads
    KALLISTO_QUANTIFY_RAW(reads_ch, kallisto_index)
    KALLISTO_QUANTIFY_TRIMMED(fastp_ch.reads, kallisto_index)

    // calculate index for kallisto
    hisat_index = INDEX_HISAT(params.genome)

    // quantify raw reads and trimmed reads
    hisat_output_raw = HISAT_QUANTIFY_RAW(reads_ch, hisat_index, params.genome_annotation)
    hisat_output_trimmed = HISAT_QUANTIFY_TRIMMED(fastp_ch.reads, hisat_index, params.genome_annotation)

    // convert sam to bam, sort and index
    SAM2BAM_RAW(hisat_output_raw.sam)
    SAM2BAM_TRIMMED(hisat_output_trimmed.sam)
}