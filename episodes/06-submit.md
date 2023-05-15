---
title: "Submitting a Job"
teaching: 40
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do I launch a program to run on a compute node in the cluster?
- How do I capture the output of a program that is run on a node in the
  cluster?
- How do I change resource requested or time-limit 

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Submit a simple script to the cluster.
- Monitor the execution of jobs using command line tools.
- Inspect the output and error files of your jobs.
::::::::::::::::::::::::::::::::::::::::::::::::

## Running a Batch Job

The most basic use of the scheduler is to run a command non-interactively. Any
command (or series of commands) that you want to run on the cluster is called a
_job_, and the process of using a scheduler to run the job is called _batch job
submission_.

Basic steps are:
  
  * Develop a submission script, a text file of commands, to perform the work
  * Submit the script to the batch system with enough resource specification
  * Monitor your jobs
  * Check script and command output
  * Evaluate your job
  
In this episode we will focus on the first 4 steps.

### Preparing a job script

In this case, the job we want to run is a shell script -- essentially a
text file containing a list of Linux commands to be executed in a sequential
manner. 

Our first shell script will have three parts:

* On the very first line, add `#!/bin/bash`. The `#!`
  (pronounced "hash-bang" or "shebang") tells the computer what program is
  meant to process the contents of this file. In this case, we are telling it
  that the commands that follow are written for the command-line shell.
* Anywhere below the first line, we'll add an `echo` command with a friendly
  greeting. When run, the shell script will print whatever comes after `echo`
  in the terminal.
  * `echo -n` will print everything that follows, _without_ ending
    the line by printing the new-line character.
* On the last line, we'll invoke the `hostname` command, which will print the
  name of the machine the script is run on.

```bash
nano example-job.sh
```
```bash
#!/bin/bash
echo -n "This script is running on "
hostname
```

::: challenge

### Exercise 1: Run example-job.sh

Run the script. Does it execute on the cluster or just our login node?

:::::: solution
```bash
bash example-job.sh
```
```output
This script is running on Slurm-login01.hpc.wehi.edu.au
```

`Slurm-login01.hpc.wehi.edu.au` may change depending on which node you ssh'ed into to run the script.

::::::
:::

This script ran on the login node, but we want to take advantage of the compute nodes, we need the scheduler to queue up `example-job.sh` to run on a compute node.

### Submit a batch job

To submit this task to the scheduler, we use the `sbatch` command.
This creates a _job_ which will run the _script_ when _dispatched_ to
a compute node which the queuing system has identified as being
available to perform the work.

```bash
sbatch example-job.sh
```
```output
Submitted batch job 11783863
```

And that's all we need to do to submit a job. Our work is done -- now the
scheduler takes over and tries to run the job for us. 

### Monitor your batch job

While the job is waiting
to run, it goes into a list of jobs called the _queue_. To check on our job's
status, we check the queue using the command
`squeue -u $USER`.

```bash
squeue -u $USER
```
```output
     JOBID    PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    11783909   regular example- iskander  R       0:06      1 sml-n02
```

ST is short for status and can be R (RUNNING), PD (PENDING), CA (CANCELLED), or CG (COMPLETING).
If the job is stuck in pending, REASON column will reflect the reason.

* Priority: There are higher priority jobs than yours
* Resources: Job is waiting for resources
* Dependency: This job is dependent on another and it is waiting for that other job to complete
* QOSMaxCpuPerUserLimit: User has used CPUs limit of partition already
* QOSMaxMemPerUserLimit: User has used memory limit of partition already

### Where's the Output?
On the login node, this script printed output to the terminal -- but now, when the job has finished, nothing was printed to the terminal.
Cluster job output is typically redirected to a file in the directory you launched it from. 

By default, the output file is called _Slurm-<jobid>.out_

Use `ls` to find and `cat` to read the file.

::: challenge

### Exercise 2: Get output of running example-job.sh in Slurm

List files in your currrent working directory and look for a file `Slurm-11783909.out`, `11783909` will change according to your job id.
And cat the file to see output. 

What is the hostname of your job?

:::::: solution
```bash
cat Slurm-11783863.out
```
```output
This script is running on sml-n02.hpc.wehi.edu.au
```
::::::
:::


### Customising a Job

The job we just ran used all of the scheduler's default options. In a real-world scenario, that's probably not what we want. Chances are, we will need more cores, more memory, more/less time, among other special considerations. To get access to these resources we must customize our job script.

The default parameters on Milton is 2 CPU, 10MB Ram, 48-hours time-limit and runs on the regular partition

After your job has completed, you can get details of the job using `sacct` command.

```bash
sacct -j 11783909 -ojobid,jobname,ncpus,reqmem,timelimit,partition -X
```
```output
JobID           JobName      NCPUS     ReqMem  Timelimit  Partition
------------ ---------- ---------- ---------- ---------- ----------
11783909     example-j+          2        10M 2-00:00:00    regular
```

More on Slurm commands in later. 

We can change the resource specification of the job by two ways:

1. Adding extra options to the `sbatch` command

```bash
sbatch --job-name hello-world --mem 1G --cpus-per-task 1 --time 1:00:00 example-job.sh
```
2. Modifying the submission script

```bash
#!/bin/bash
#SBATCH --job-name hello-world
#SBATCH --mem 1G
#SBATCH --cpus-per-task 1
#SBATCH  --time 1:00:00
echo -n "This script is running on "
hostname
```

3. Submit the job and monitor its status:
    
```bash
sbatch example-job.sh
```
```output
Submitted batch job 11785584
```
```bash
squeue -u $USER
```
```output
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          11785584   regular hello-wo iskander  R       0:01      1 sml-n20
```

Comments in shell scripts (denoted by `#`) are typically ignored, but there are exceptions. For instance, the special `#!` comment at the beginning of scripts specifies what program should be used to run it. Schedulers like Slurm also have a special comment used to denote special scheduler-specific options. Though these comments differ from scheduler to scheduler, Slurm's special comment is `#SBATCH`. Anything following the `#SBATCH` comment is interpreted as an instruction to the scheduler.

**Remember** Slurm directives must be at the top of the script, below the "hash bang". No command can come before them, nor in between them.

### Resource Requests

One thing that is absolutely critical when working on an HPC system is specifying the resources required to run a job. This allows the scheduler to find the right time and place to schedule our job. As we have seen before, if you do not specify requirements, you will be stuck with default resources, which is probably not what you want.

The following are several key resource requests:

* `--ntasks` or `-n` : Number of tasks (used for distributed processing, e.g. MPI workers). There is also --ntasks-per-node. default = 1		
* `--time` or `-t` : Time (wall-time) required for a job to run. The <days> part can be omitted. default = 48 hours on the regular queue
* `--mem`: Memory requested per node in MiB. Add G to specify GiB (e.g. 10G). There is also `--mem-per-cpu`. default = 10M
* `--nodes` or `-N`: Number of nodes your job needs to run on. Note that if you set ntasks to a number greater than what one machine can offer, Slurm will set this value automatically. default = 1 
* `--cpus-per-task` or `-c`: Number of CPUs for each task. Use this for threads/cores in single-node jobs.
* `--partition` or `-p`: the partition (queue) in which your job is placed. default = regular
* `--gres`: special resources such as GPUs. To specify GPUs, use gpu:<type>:<number>, for example, `--gres=gpu:P100:1`, and **you must specify the correct partition (gpuq or gpuq_large)**

Note that just _requesting_ these resources does not make your job run faster, nor does it necessarily mean that you will consume all of these resources. It only means that these are made available to you. Your job may end up using less
memory, or less time, or fewer nodes than you have requested, and it will still run.

It's best if your requests accurately reflect your job's requirements. We'll talk more about how to make sure that you're using resources effectively in a later episode of this lesson.

**Main parts of a _Slurm_ submission script**

1. **#! line**: 
  
  This must be the first line of your SBATCH/Slurm script.
  
  ```bash
  #!/bin/bash
  ```
  
2. **Resource Request**:

  This section is used to set the amount of resources required for the job. This informs Slurm about the name of the job, output filename, amount of RAM, Nos. of CPUs, nodes, tasks, time, and other parameters to be used for processing the job. These SBATCH commands are also know as SBATCH directives 
  
```bash
#SBATCH --job-name=TestJob
#SBATCH --output=TestJob.out
#SBATCH --time=1-00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
```
  
3. **Dependencies**: 

  Load all the software that the project depends on to execute. For example, if you are working on a python project, you’d definitely require the python software or module to interpret and run your code.
  
```bash
module load python
```
  
4. **Job Steps** 

  Specify the list of tasks to be carried out.

```bash
echo "Start process"
hostname
sleep 30
echo "End"
```

::: challenge

### Exercise 3: Setting appropriate wall-time

List then run Exercises/job1.sh script in the batch system. What is the output?
Is there an error? How can you fix it?
```bash
#!/bin/bash
#SBATCH -t 00:01:00 

echo -n "This script is running on "
sleep 70 # time in seconds
hostname
```
:::

:::::: solution

After 1 minute the job ends and the output is similar to this
```bash
cat Slurm-11792811.out 
```
```output
This script is running on Slurmstepd: error: *** JOB 11792811 ON sml-n24 CANCELLED AT 2023-05-13T20:41:10 DUE TO TIME LIMIT ***
```
To fix it, change the script to 
```bash
#!/bin/bash
#SBATCH -t 00:01:20 # timeout in HH:MM

echo -n "This script is running on "
sleep 70 # time in seconds
hostname
```
Try running again.
::::::


Resource requests are typically binding. If you exceed them, your job will be killed. 

The job was killed for exceeding the amount of resources it requested. Although this appears harsh, this is actually a feature. Strict adherence to resource requests allows the scheduler to find the best possible place for your jobs. Even more importantly, it ensures that another user cannot use more resources than they've been given. If another user messes up and accidentally attempts to use all of the cores or memory on a node, Slurm will either restrain their job to the requested resources or kill the job outright. Other jobs on the node will be unaffected. This means that one user cannot mess up the experience of others, the only jobs affected by a mistake in scheduling will be their own.



::: challenge

### Exercise 4: Setting appropriate Slurm directives

List then run Exercises/job2.sh script in the batch system. What is the output?
Is there an error? How can you fix it?
```bash
#!/bin/bash
#SBATCH -t 00:01:00
#SBATCH --gres gpu:P100:1
#SBATCH  --mem 1G
#SBATCH --cpus-per-task 1

#This is  a job that needs GPUs
echo -n "This script is running on "
hostname
```

:::::::::::::

:::::: solution

When submitting to Slurm, you get an error
```bash
sbatch job2.sh
```
```output
sbatch: error: Batch job submission failed: Requested node configuration is not available
```

This is because a GPU was requested without specifying the correct GPU partition, so the regular partition was used which has no GPUs. To fix it, change the script to 
```bash
#!/bin/bash
#SBATCH -t 00:01:00
#SBATCH -p gpuq
#SBATCH --gres gpu:P100:1
#SBATCH  --mem 1G
#SBATCH --cpus-per-task 1

#This is  a job that needs GPUs
echo -n "This script is running on "
hostname
```
Try running again.
::::::

## Cancelling a Job

Sometimes we'll make a mistake and need to cancel a job. This can be done with the `scancel` command. Let's submit a job and then cancel it using its job number.

```bash
sbatch example-jobwithsleep.sh
```
```output
Submitted batch job 11785772
```
```bash
squeue -u $USER
```
```output
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          11785772   regular example- iskander  R       0:10      1 sml-n20
```
```bash
scancel 11785772
squeue -u $USER
```
```output
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
```

We can also cancel all of our jobs at once using the `-u` option. This will cancel all jobs for a specific user (in this case, yourself). Note that you can only cancel your own jobs.

::: challenge

### Exercise 5

Make alignment job (`job3.sh`) work.

:::

:::::: solution

Add the correct Slurm directives to the start of the script
```
#SBATCH --job-name=Bowtie-test.Slurm
#SBATCH --ntasks=1
#SBATCH -t 0:15:00
#SBATCH --mem 20G
```
::::::

::: challenge

### Exercise 6

Run `job3.sh` again and monitor progress on the node. You can do this by
sshing to the node and running `top`.

:::

:::::: solution
Run the job
get which node it is running on from `squeue -u $USER`
ssh into the node 
use `top -u $USER`
::::::

::: challenge

### Exercise 7

Submit multiple jobs and then cancelling them all.

:::

:::::: solution
```bash
sbatch job1.sh
sbatch job1.sh
sbatch job1.sh
sbatch job1.sh
```
Check what you have in the queue

```bash
squeue -u $USER
```
```output
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          11792908   regular  job1.sh iskander  R       0:13      1 sml-n23
          11792909   regular  job1.sh iskander  R       0:13      1 sml-n23
          11792906   regular  job1.sh iskander  R       0:16      1 sml-n23
          11792907   regular  job1.sh iskander  R       0:16      1 sml-n23
```
Cancel the jobs

```
$ scancel -u $USER
```

Recheck the queue

```
$ squeue -u $USER
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
```

And the queue is empty.

::::::


You can check how busy the queue is through the [Milton dashboards](http://dashboards.hpc.wehi.edu.au/d/main/main?orgId=1)

## Slurm Event notification

You can use `--mail-type` and `--mail-user` to set Slurm to send you emails when certain evenmts occurs, e.g. BEGIN, END, FAIL, REQUEUE, ALL 

```
#SBATCH --mail-type BEGIN
#SBATCH --mail-user iskander.j@wehi.edu.au
```
Adding the above two lines to a submission script will make Slurm send me an email when my job starts running.

## Slurm Output files

By default both standard output and standard error are directed to a file of the name "slurm-%j.out", where the "%j" is replaced with the job id. The file will be saved in the submission directory as we saw before.
on the first node of the job allocation. Other than the batch script itself, Slurm does no movement of user files.

You can choose where the output files is saved and also separate standard output from standard error using `--output` and `--error`

* `--output` can be used to change the standard output filename and location.
* `--error` can be used to specify where the standard output file shall be saved. If not specified, it will be directed to the standard output file.

In the file names you can use:

* %j for Job Id
* %N for Host name
* %u User name
* %x Job name

For example, running the following 
`sbatch --error=/vast/scratch/users/%u/Slurm%j_%N_%x.err --output=/vast/scratch/users/%u/Slurm%j_%N_%x.out job1.sh`
will write error to a file (for example) `Slurm12345678_sml-n01_job1.sh.err` and output to `Slurm12345678_sml-n01_job1.sh.out`
in the directory `/vast/scratch/users/<username>`.


::::::::::::::::::::::::::::::::::::: keypoints 

- `sbatch` is used to submit the job
- `squeue` is used to list jobs in the Slurm queue
  - passing the `-u <username>` option will show jobs for just that user.
- `sacct` is used to show job details
- `#SBATCH` directives are used in submission scripts to set Slurm directives
- Setting up job resources is a challenge and you might not get the first time

::::::::::::::::::::::::::::::::::::::::::::::::