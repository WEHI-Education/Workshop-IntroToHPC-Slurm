#!/bin/bash

#SBATCH --job-name=Bowtie-test.slurm
#SBATCH --ntasks=1
#SBATCH -t 0:15:00

# Load the environment variables
module purge

module load bowtie2/2.5.3
module load samtools/1.21  
module load bcftools/1.21


# Build an index 
bowtie2-build 	bowtie/pO157_Sakai.fasta.gz 	bowtie/pO157_Sakai

# Map the reads, using the trimmed data from fastqc (qv)

bowtie2 -x	bowtie/pO157_Sakai -1 	bowtie/SRR957824_trimmed_R1.fastq -2 	bowtie/SRR957824_trimmed_R2.fastq -S 	bowtie/SRR957824.sam

