---
title: "Interactive Slurm Jobs"
teaching: 10
exercises: 0
---

:::::::::::::::::::::::::::::::::::::: questions 

- How to start and exit an interactive Slurm job?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how to use `salloc` to run interactive jobs

::::::::::::::::::::::::::::::::::::::::::::::::

## Interactive jobs

Up to this point, we've focused on running jobs in batch mode. There are frequently tasks that need to be done interactively. Creating an
entire job script might be overkill, but the amount of resources required is
too much for a login node to handle. To solve this, Slurm provides the ability to start an interactive session.

Interactive sessions are **commonly used** for:

* Data management, eg. organising files, truncation and recall of files, downloading datasets.
* Software/workflow preparation/testing, eg. developing/debugging scripts, downloading/building software.
* Interactive data analysis.
* Rapid analysis cycles.
* Running n application with a GUI.


On Milton, you can easily start an interactive job with `salloc`.

```bash
salloc --time 1:00:00 --cpus-per-task 1 --mem 1G  -p interactive
```
![salloc command example](fig/salloc_ex.png)

You will be presented with a bash prompt. Note that the prompt will change to reflect your new location (`sml-n02` in the example), which is the compute node we are logged onto. You can also verify this with hostname.

**Remember** that, you may have to wait for resources, depending on the status of the queue you are requesting. We have designed the interactive partition to provide high availability, but only one job per user.

The interactive job will be cancelled and removed from the queue, if your terminal session is terminated or closed, and/or internet connection is lost (connection with the slurm node lost). It is recommended to use `screen` or `tmux`

When you have finished your task, please remember to close the session using `exit` or `Ctrl-D`.

You can also cancel the session using `scancel`.

If you need more resources you can run interactive sessions in the other partitions.

::: callout

### These instructions are specific Milton!

`salloc` is setup slightly differently to its default behaviour. Not all HPC facilities
have Slurm to start interactive jobs like in Milton! Be aware of this when using
the command at other facilities.

:::::::::::

## Creating remote graphics
To see graphical output inside your jobs, you need to use _X11 forwarding_. To connect with this feature enabled, use the `-Y` option when you login to the login nodes or vc7-shared.  
```
ssh -Y vc7-shared
```

To use it in an interactive session add it to `--x11` to your `salloc` command

```bash
salloc --time 1:00:00 --cpus-per-task 1 --mem 1G  -p interactive --x11
```
```output
salloc: Pending job allocation 11803274
salloc: job 11803274 queued and waiting for resources
salloc: job 11803274 has been allocated resources
salloc: Granted job allocation 11803274
salloc: Nodes sml-n03 are ready for job
```

```bash
module load relion
```
```output
Loading Relion 3.1.3 using CUDA 11.2
Using MotionCor2 1.5.0 at /stornext/System/data/nvidia/motioncor2/motioncor2-1.5.0cu11.2/bin/motioncor2
No matching version of Gctf exists for CUDA 11.2
Using CTFFIND 4.1.14 at /stornext/System/data/nvidia/ctffind/ctffind-4.1.14/bin/ctffind

        WARNING: verify that the area where Relion will be used
        is not over its storage quota. If Relion is unable to write
        files this might cause severe corruption in the Relion
        pipeline star files.


Loading relion/3.1.3-cu11.2
  Loading requirement: cuda/11.2 mpich-slurm/3.4.2
```
```bash
relion
```

![](fig/relion.png)

We will now have a live demo for more interactive options on Milton.

::::::::::::::::::::::::::::::::::::: keypoints 

- Use `salloc` to start a new interactive Slurm job on Milton.
- Use `--x11` with `salloc` to run remote graphics in your interactive job.

::::::::::::::::::::::::::::::::::::::::::::::::

