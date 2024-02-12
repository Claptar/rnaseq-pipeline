#!/bin/bash

# создадим директории для файлов
mkdir fastq_files
mkdir references

# скачаем fastq файлы с помощью SRA Explorer
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/033/SRR14467633/SRR14467633.fastq.gz -o fastq_files/SRR14467633.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/007/SRR14467707/SRR14467707.fastq.gz -o fastq_files/SRR14467707.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/063/SRR14467663/SRR14467663.fastq.gz -o fastq_files/SRR14467663.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/088/SRR14467788/SRR14467788.fastq.gz -o fastq_files/SRR14467788.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/067/SRR14467667/SRR14467667.fastq.gz -o fastq_files/SRR14467667.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/028/SRR14467728/SRR14467728.fastq.gz -o fastq_files/SRR14467728.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/080/SRR14467580/SRR14467580.fastq.gz -o fastq_files/SRR14467580.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/084/SRR14467684/SRR14467684.fastq.gz -o fastq_files/SRR14467684.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/087/SRR14467787/SRR14467787.fastq.gz -o fastq_files/SRR14467787.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/065/SRR14467465/SRR14467465.fastq.gz -o fastq_files/SRR14467465.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/069/SRR14467569/SRR14467569.fastq.gz -o fastq_files/SRR14467569.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR144/019/SRR14467819/SRR14467819.fastq.gz -o fastq_files/SRR14467819.fastq.gz


# скачаем референс транскриптома с NCBI
wget https://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Homo_sapiens/reference/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna.gz
gzip -d GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna.gz
mv GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna references/ncbi_transcriptome.fna

# скачаем референс генома с NCBI
wget https://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Homo_sapiens/reference/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz
gzip -d GCF_000001405.40_GRCh38.p14_genomic.fna.gz
mv GCF_000001405.40_GRCh38.p14_genomic.fna references/ncbi_genome.fna

# скачаем аннотацию
wget https://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Homo_sapiens/reference/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.gtf.gz
gzip -d GCF_000001405.40_GRCh38.p14_genomic.gtf.gz
mv GCF_000001405.40_GRCh38.p14_genomic.gtf references/ncbi_genome.gtf