# Intro to HPC and SLURM on WEHI Milton

This lesson is created using [The Carpentries Workbench](https://carpentries.github.io/sandpaper-docs/) and is based on [Introduction to High-Performance Compting](https://carpentries-incubator.github.io/hpc-intro/). It has been customised to work for users of WEHI Milton.

This course is for scientists who have no experience with high performance computing (HPC) and want to learn how to start using WEHI HPC, Milton. The course teaches basics of interacting with HPC and what it means to use a batch system (scheduling system) like SLURM. Scientists will learn how to login into Milton, prepare their scripts and submit jobs. It will also cover, estimating resources and job efficiency. 

This course will be delivered mostly using live-coding demonstrations and exercises. The entire workshop is delivered in approximately 3 1-hour chunks with breaks in between. 

[![Build Status][badge-img]][badge-lnk]

This course is maintained by [WEHI Research computing](mailto:research.computing@wehi.edu.au)
* [@jIskCoder](https://github.com/jIskCoder)
* [@edoyango](https://github.com/edoyango)
* [@multimeric](https://github.com/multimeric)

## Lesson Outlines

[User profiles](_extras/learner-profiles.md) of people approaching
high-performance computing from an academic and/or commercial background are
provided to help guide planning and decision-making.

1. [Why use a cluster?](_episodes/11-hpc-intro.md) (20 minutes)

   * Brief, concentrate on the concepts not details like interconnect type, etc.
   * Be able to describe what a compute cluster (HPC/HTC system) is
   * Explain how a cluster differs from a laptop, desktop, cloud, or "server"
   * Identify how an compute cluster could benefit you.
   * Jargon busting

1. [Working on a remote HPC system](_episodes/12-cluster.md) (35 minutes)

   * Understand the purpose of using a terminal program and SSH
   * Learn the basics of working on a remote system
   * Know the differences of between login and compute nodes
   * Objectives: Connect to a cluster using ssh; Transfer files to and from the
     cluster; Run the hostname command on a compute node of the cluster.
   * Potential tools: `ssh`, `ls`, `hostname`, `logout`, `nproc`, `free`,
     `scp`, `man`, `wget`

1. [Working with the scheduler](_episodes/13-scheduler.md) (1 hour 15 minutes)

   * Know how to submit a program and batch script to the cluster (interactive &
     batch)
   * Use the batch system command line tools to monitor the execution of your
     job.
   * Inspect the output and error files of your jobs.
   * Potential tools: shell script, `sbatch`, `squeue -u`, `watch`, `-N`, `-n`,
     `-c`, `--mem`, `--time`, `scancel`, `srun`, `--x11 --pty`,
   * Extras: `--mail-user`, `--mail-type`,
   * Remove? `watch`
   * Later lessons? `-N` `-n` `-c`

1. [Accessing software via Modules](_episodes/14-modules.md) (45 minutes)

   * Understand the runtime environment at login
   * Learn how software modules can modify your environment
   * Learn how modules prevent problems and promote reproducibility
   * Objectives: how to load and use a software package.
   * Tools: `module avail`, `module load`, `which`, `echo $PATH`, `module
     list`, `module unload`, `module purge`, `.bashrc`, `.bash_profile`, `git
     clone`, `make`
   * Remove: `make`, `git clone`,
   * Extras: `.bashrc`, `.bash_profile`

1. [Transferring files with remote computers](
   _episodes/15-transferring-files.md) (30 minutes)

   * Understand the (cognitive) limitations that remote systems don't
     necessarily have local Finder/Explorer windows
   * Be mindful of network and speed restrictions (e.g. cannot push from
     cluster; many files vs one archive)
   * Know what tools can be used for file transfers, and transfer modes (binary
     vs text)
   * Objective: Be able to transfer files to and from a computing cluster.
   * Tools: `wget`, `scp`, `rsync` (callout), `mkdir`, FileZilla,
   * Remove: `dos2unix`, `unix2dos`,
   * Bonus: `gzip`, `tar`, `dos2unix`, `cat`, `unix2dos`, `sftp`, `pwd`,
     `lpwd`, `put`, `get`

1. [Running a parallel job](_episodes/16-parallel.md) (1 hour)

   * Introduce message passing and MPI as the fundamental engine of parallel
     software
   * Walk through a simple Python program for estimation of π
   * Use [mpi4py][mpi4py] to parallelize the program
   * Write job submission scripts & run the job on a cluster node
   * Tools: `nano`, `sbatch`, `squeue`

1. [Using resources effectively](_episodes/17-resources.md) (40 minutes)

   * Understand how to look up job statistics
   * Learn how to use job statistics to understand the health of your jobs
   * Learn some very basic techniques to monitor / profile code execution.
   * Understand job size and resource request implications.
   * Tools: `fastqc`, `sacct`, `ssh`, `top`, `free`, `ps`, `kill`, `killall`
     (note that some of these may not be appropriate on shared systems)

1. [Using shared resources responsibly](_episodes/18-responsibility.md) (20
   minutes)

   * Discuss the ways some activities can affect everyone else on the system

### Nascent lesson ideas

1. Playing friendly in the cluster (psteinb: the following is very tricky as it
   is site dependent, I personally would like to see it in [_extras][extras])

   * Understanding resource utilisation
   * Profiling code - time, size, etc.
   * Getting system stats
   * Consequences of going over

1. Filesystems and Storage: objectives likely include items from @psteinb's
   [Shared Filesystem lesson][hpcday-fs]:

   * Understand the difference between a local and shared / network filesystem
   * Learn about high performance / scratch filesystems
   * Raise attention that misuse (intentional or not) of a common file system
     negatively affects all users very quickly.
   * Possible tools: `echo $TEMP`, `ls -al /tmp`, `df`, `quota`

1. Advanced Job Scripting and Submission:

   * Checking status of jobs (`squeue`, `bjobs` etc.), explain different job
     states and relate to scheduler basics
   * Cancelling/deleting a job (`scancel`, `bkill` etc.)
   * Passing options to the scheduler (log files)
   * Callout: Changing a job's name
   * Optional Callout: Send an email once the job completes (not all sites
     support sending emails)
   * for a starting point, see [this][hpcday-sched] for reference

1. Filesystem Zoo:

   * execute a job that collects node information and stores the output to
     `/tmp`
   * ask participants where the output went and why they can't see it
   * execute a job that collects node information and stores the output to
     `/shared` or however your shared file system is called
   * for a starting point, see [this][hpcday-fs]

<!-- links -->
[badge-img]: https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fcarpentries-incubator%2Fhpc-intro%2Fbadge%3Fref%3Dgh-pages&style=flat
[badge-lnk]: https://actions-badge.atrox.dev/carpentries-incubator/hpc-intro/goto?ref=gh-pages
[ex-lesson]: https://github.com/carpentries/lesson-example
[extras]: https://github.com/carpentries-incubator/hpc-intro/tree/gh-pages/_extras
[hpcday-fs]: https://github.com/psteinb/hpc-in-a-day/blob/gh-pages/_episodes/01-04-shared-filesystem.md
[hpcday-sched]: https://psteinb.github.io/hpc-in-a-day/02-02-advanced-job-scheduling
[liquid]: https://shopify.github.io/liquid/
[mpi4py]: https://mpi4py.readthedocs.io
[setup]: http://carpentries.github.io/lesson-example/setup.html
[upstream]: https://github.com/carpentries-incubator/hpc-intro



If you have any questions, contact [@jIskCoder](https://github.com/jIskCoder)
[workbench]: https://carpentries.github.io/sandpaper-docs/
