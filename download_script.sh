#!/bin/bash

# создадим директории для файлов
mkdir fastq_files
mkdir references

# скачаем fastq файлы с помощью SRA Explorer
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR281/001/SRR2816121/SRR2816121.fastq.gz -o fastq_files/SRR2816121.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR281/002/SRR2816122/SRR2816122.fastq.gz -o fastq_files/SRR2816122.fastq.gz

# скачаем референс транскриптома с ENSEMBL
wget https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz
gzip -d Homo_sapiens.GRCh38.cdna.all.fa.gz
mv Homo_sapiens.GRCh38.cdna.all.fa references/transcriptome.fa

# скачаем референс генома с ENSEMBL
wget https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
gzip -d Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
mv Homo_sapiens.GRCh38.dna.primary_assembly.fa references/genome.fa

# скачаем аннотацию
wget https://ftp.ensembl.org/pub/release-110/gtf/homo_sapiens/Homo_sapiens.GRCh38.110.gtf.gz
gzip -d Homo_sapiens.GRCh38.110.gtf.gz
mv Homo_sapiens.GRCh38.110.gtf references/genome.gtf