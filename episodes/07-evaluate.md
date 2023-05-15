---
title: "Evaluating Jobs"
teaching: 20
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How to evaluate a completed job?
- How to set event notification for your jobs?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain Slurm environment variables.
- Demonstrate how to evaluate jobs and make use of multiple threads options.

::::::::::::::::::::::::::::::::::::::::::::::::


## Evaluating your Job

After a job has completed, you will need to evaluate how efficient it was if it ran successfully, or investigate why it failed.

The `seff` command provides a summary of any job.
```bash
seff <jobid>
```


::: challenge

### Exercise 1: Run and evaluate job4.sh .

job4.sh is similar to job3.sh with only the `bowtie2` command. Try submitting it. 
Is there an error? How to fix it?

And after it completed successfully, evaluate the job. 

:::

:::::: solution
The jobs completes fast but not successfully
```bash
seff 11793501
```
```output
Job ID: 11793501
Cluster: milton
User/Group: iskander.j/allstaff
State: OUT_OF_MEMORY (exit code 0)
Nodes: 1
Cores per node: 2
CPU Utilized: 00:00:01
CPU Efficiency: 50.00% of 00:00:02 core-walltime
Job Wall-clock time: 00:00:01
Memory Utilized: 0.00 MB (estimated maximum)
Memory Efficiency: 0.00% of 20.00 MB (10.00 MB/core)
```

Also, checking output
```bash
cat Slurm-11793501.out
```
```output
.........................<other output>
slurmstepd: error: Detected 1 oom_kill event in StepId=11793501.batch. Some of the step tasks have been OOM Killed.
```
This shows that the job was "OOM Killed". OOM is an abbreviation of **O**ut **O**f **M**emory, meaning the memory requested was not enough, increase memory and try again until job finishes successfully.
```bash
#SBATCH --job-name=Bowtie-test.Slurm
#SBATCH --ntasks=1
#SBATCH -t 0:15:00
#SBATCH --mem 1G
```
::::::

::: challenge

### Exercise 2: Run and evaluate job4.sh .

Now that the job works fine can we make it faster.

:::

:::::: solution
Investigate whether bowtie2 can make use of multiple threads to accelerate run. Some tools does.

```bash
bowtie2 --help
```

Indeed bowtie, has a `-p` option that specifies number of threads to use.
Update the script to use 6 threads and also increase cpus-per-tasks to reflect the increase in threads.

::::::

## Slurm Environment Variables

Slurm passes information about the running job e.g what its working directory, or what nodes were allocated for it, to the job via environmental variables. In addition to being available to your job, these are also used by programs to set options like number of threads to run based on the cpus available. 

The following is a list of commonly used variables that are set by Slurm for each job

* `$SLURM_JOBID`: Job id
* `$SLURM_SUBMIT_DIR`: Submission directory
* `$SLURM_SUBMIT_HOST`: Host submitted from
* `$SLURM_JOB_NODELIST`: list of nodes where cores are allocated
* `$SLURM_CPUS_PER_TASK`: number of cores per task allocated
* `$SLURM_NTASKS`: number of tasks assigned to job

::: challenge

### Exercise 3: Run job5.sh.

Can we make use on of Slurm environment variables in job4.sh?

:::

:::::: solution
use `$SLURM_CPUS_PER_TASK` with `-p` option instead of setting a number.
::::::

We can have a live-demo on how to monitor a running job on the compute node, using `top`, `iotop` and `nvtop` for GPU nodes

::::::::::::::::::::::::::::::::::::: keypoints 

- Use `seff` to evaluate completed jobs
- Slurm Environment variables are handy to use in your script

::::::::::::::::::::::::::::::::::::::::::::::::

