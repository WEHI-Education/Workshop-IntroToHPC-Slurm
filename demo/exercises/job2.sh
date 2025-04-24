#!/bin/bash
#SBATCH -t 00:10:00
#SBATCH --gres gpu:P100:1
#SBATCH  --mem 1G
#SBATCH --cpus-per-task 1

#This is  a job that needs GPUs
echo -n "This script is running on "
hostname
