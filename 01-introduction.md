---
title: "What is a HPC?"
teaching: 15
exercises: 0
---

:::::::::::::::::::::::::::::::::::::: questions 

- Why would I be interested in High Performance Computing (HPC)?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Describe what an HPC system is
- Identify how an HPC system could benefit you.

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction
Open the [Introduction Slides](https://wehieduau.sharepoint.com/:p:/s/rc2/EVLoeAXqz7hFuqDM59COiYkBiGvnkY-Lgh8C9pOTSeJSsA?e=BdafRQ)
in a new tab for an introduction to the course and Research Computing. 

## Defining common terms


### What is cluster computing?
Cluster computing refers to two or more computers that are networked together to provide solutions as required. 

A cluster of computers joins computational powers of the individual computers (called "compute nodes") to provide a more combined computational power.

![Cluster Computing by Trevor Dsouza from <a href="https://thenounproject.com/browse/icons/term/cluster-computing/" target="_blank" title="Cluster Computing Icons">Noun Project</a> ](fig/cluster.png)

### What is a HPC cluster?
HPC stands for High Performance Computing, which is the ability to process data and perform complex calculations at high speeds. 

In its simplest structure, HPC clusters are intended to utilize parallel processors to apply more computing force to solve a problem. HPC clusters are a kind of compute clusters that typically have a large number of compute nodes, which share a file system designed for parallel reading and writing, and use a high-speed network for communication with each other. 


### What is a supercomputer?
Supercomputer used to refer to any single computer system that has exceptional processing power for its time. But recently, it refers to the best-known types of HPC solutions. A supercomputer contains thousands of compute nodes that work together to complete one or more tasks in parallel. 



::: callout
`supercomputers` and `high-performance computers` are often used interchangeably.
::: 


### How is supercomputing performance measured?
The most popular benchmark is the [LINPACK benchmark](https://www.top500.org/project/linpack/) which is used for the [TOP500](https://www.top500.org/lists/top500). The LINPACK benchmark reflect the performance of a dedicated system for solving a dense system of linear equations. It uses the number of floating point operations per second (FLOPS) as the metric. The [GREEN500](https://www.top500.org/lists/green500/) ranking has also risen in popularity as it ranks HPC systems based on FLOPS per Watt of power (higher the better).

## When to use a HPC cluster? 
Frequently, research problems that use computing can outgrow the capabilities
of the desktop or laptop computer where they started, such as the following examples

>* A statistics student wants to cross-validate a model. This involves running
  the model 1000 times -- but each run takes an hour. Running the model on
  a laptop will take over a month! In this research problem, final results are
  calculated after all 1000 models have run, but typically only one model is
  run at a time (in __serial__) on the laptop. Since each of the 1000 runs is
  independent of all others, and given enough computers, it's theoretically
  possible to run them all at once (in __parallel__).
>* A genomics researcher has been using small datasets of sequence data, but
  soon will be receiving a new type of sequencing data that is 10 times as
  large. It's already challenging to open the datasets on a computer --
  analyzing these larger datasets will probably crash it. In this research
  problem, the calculations required might be impossible to parallelize, but a
  computer with __more memory__ would be required to analyze the much larger
  future data set.


In these cases, access to **more** (and **larger**) computers is needed. Those
computers should be usable at the same time, __solving many researchers'
problems in parallel__.

Therefore, HPCs are userful when you have:

* A program that can be recompiled or reconfigured to use optimized numerical libraries that are available on HPC systems but not on your own system;
* You have a parallel problem, e.g. you have a single application that needs to be rerun many times with different parameters;
* You have an application that has already been designed with parallelism;
* To make use of the large memory available;
* When solutions require backups for future use. HPC facilities are reliable and regularly backed up.

## How to interact with HPC clusters?
Researchers usually interact with HPC clusters by connecting remotely to the HPC cluster via the Linux command line.
This is because of its low cost and setup as well as most research HPC software being written for the
Linux command line. Microsoft Windows HPC facilities exist, but usually serve specific niches like corporate finance.

However, graphical interfaces have become popular and have helped lower the barrier
to learning how to use HPC. [Open OnDemand](https://openondemand.org/) being the most popular example of software
that helps users interact with HPC graphically.

## What is Milton?

![](fig/milton.png)

In 2016, WEHI purchased an on-premise HPC cluster called Milton, Milton includes >4500-cores (2 hyperthreads per core), >60TB memory, ~ 58 GPUs, >10 petabytes of tiered-storage. All details are available [here](https://wehieduau.sharepoint.com/sites/rc2/SitePages/Milton-hardware.aspx).

Milton contains a mix of Skylake, Broadwell, Icelake and Cooperlake Intel processors.


![](fig/miltonschematic.png)




::::::::::::::::::::::::::::::::::::: keypoints 

- Using High Performance Computing (HPC) typically involves connecting to very large
  computing systems that provides a high computational power.
- These systems can be used to do work that would either be impossible
  or much slower on smaller systems.
- HPC resources are shared by multiple users.
- The resources found on independent compute nodes can vary in volume and type (amount of RAM, processor architecture, availability of shared filesystems, etc.).
- The standard method of interacting with HPC systems is via a command line interface.

::::::::::::::::::::::::::::::::::::::::::::::::
