#!/bin/bash

# Load the environment variables
module purge
module load bowtie2/2.5.3
module load samtools/1.21  
module load bcftools/1.21

# Build an index 
echo "Step 1: Build the index"
bowtie2-build bowtie/pO157_Sakai.fasta.gz bowtie/pO157_Sakai

# Map the reads, using the trimmed data from fastqc (qv)
echo "Step 2: Map the reads"
bowtie2 -p 6 -x bowtie/pO157_Sakai -1 bowtie/SRR957824_trimmed_R1.fastq.gz -2 bowtie/SRR957824_trimmed_R2.fastq.gz -S bowtie/SRR957824.sam

# Convert the SAM file into BAM, a compressed version of SAM that can be indexed.
echo "Step 3: Convert SAM to BAM"
samtools view -h -S -b --threads 6 -o bowtie/SRR957824.bam bowtie/SRR957824.sam
# from the reference genome. Single nucleotide polymorphism (SNP)-based typing is particul

# Sort the bam file per position in the genome and index it
echo  "Step 4: Sort the BAM "
samtools sort --threads 6 bowtie/SRR957824.bam -o bowtie/SRR2584857.sorted.bam

echo "Step 5: Index the sorted BAM"
samtools index -@ 6 bowtie/SRR2584857.sorted.bam
 
# A frequent application for mapping reads is variant calling, i.e. finding positions where the reads are systematically different 
# from the reference genome. Single nucleotide polymorphism (SNP)-based typing is particularly popular and used for a broad range of 
# applications. For an EHEC O157 outbreak you could use it to identify the source, for instance.

echo "Step 6: View SNPs"
bcftools mpileup -D -f bowtie/pO157_Sakai.fasta.gz bowtie/SRR2584857.sorted.bam | bcftools view - > bowtie/variants.vcf