#!/bin/bash


# Load the environment variables
module purge

module load bowtie2/2.5.3
module load samtools/1.21  
module load bcftools/1.21


# Build an index 
bowtie2-build 	bowtie/pO157_Sakai.fasta.gz 	bowtie/pO157_Sakai

# Map the reads, using the trimmed data from fastqc (qv)

bowtie2 -p 6 -x	bowtie/pO157_Sakai -1 	bowtie/SRR957824_trimmed_R1.fastq -2 	bowtie/SRR957824_trimmed_R2.fastq -S 	bowtie/SRR957824.sam

# Convert the SAM file into BAM, a compressed version of SAM that can be indexed.

samtools view -h -S -b --threads 6 -o bowtie/SRR957824.bam bowtie/SRR957824.sam

# Sort the bam file per position in the genome and index it

samtools sort --threads 6 bowtie/SRR957824.bam -o bowtie/SRR2584857.sorted.bam

samtools index -@ 6 bowtie/SRR2584857.sorted.bam


 
# A frequent application for mapping reads is variant calling, i.e. finding positions where the reads are systematically different 
# from the reference genome. Single nucleotide polymorphism (SNP)-based typing is particularly popular and used for a broad range of 
# applications. For an EHEC O157 outbreak you could use it to identify the source, for instance.

bcftools mpileup -D -f bowtie/pO157_Sakai.fasta.gz bowtie/SRR2584857.sorted.bam | bcftools view - > bowtie/variants.vcf
