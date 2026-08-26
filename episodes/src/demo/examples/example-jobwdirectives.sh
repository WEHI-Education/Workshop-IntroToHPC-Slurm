#!/bin/bash

#SBATCH --job-name hello-world
#SBATCH --mem 1G
#SBATCH --cpus-per-task 1
#SBATCH  --time 1:00:00

sleep 5s
echo -n "This script is running on "
hostname