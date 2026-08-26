#!/bin/bash


#SBATCH --job-name=Bowtie-test.slurm
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH -t 0:15:00
#SBATCH --mem 10M


echo "Job started with job id $SLURM_JOBID"
echo "Submission directory is $SLURM_SUBMIT_DIR and the submission host is $SLURM_SUBMIT_HOST"
echo "The job is running on the following nodes: $SLURM_JOB_NODELIST and using $SLURM_CPUS_PER_TASK cpu(s) and $SLURM_NTASKS task(s)"

