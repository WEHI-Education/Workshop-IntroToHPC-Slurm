---
title: "Slurm Commands"
teaching: 20
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How to use Slurm commands?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how to use the other Slurm commands?
- Demonstrate different options for Slurm commands like `squeue` and `sinfo`.

::::::::::::::::::::::::::::::::::::::::::::::::

## Slurm Commands Summary


| Command    |Action   |
|-------|----------|
|`sbatch <script>` |Submit a batch script |
|`sacct` | Display job details (accounting data) |
|`sacctmgr` | View account information |
|`squeue` | View information of jobs currently in queue |
|`squeue -j <jobid>`|Get specific job details, job should be in the queue|
|`squeue -u <userid>`|Get all queued job details for specified user|
|`scancel <jobid>` | Cancel job |
|`sinfo` | View information about nodes and partitions|
| `sinfo -N`| View list of nodes|
|`sinfo -s`| Provides nodes' state information in each partitions|
|`sinfo -p <partition>`| Provides nodes' state information in the specified partition|
|`scontrol show job <jobid>`| View detailed job information |
|`scontrol show partition <partition>` | View detailed partition information |


::: challenge

### Exercise 1: sinfo with options
What output does the following command produce?

```bash
sinfo -p gpuq -s
```

:::

:::::: solution

Provides summary information of only the specified partition
```output
PARTITION AVAIL  TIMELIMIT   NODES(A/I/O/T) NODELIST
gpuq         up 2-00:00:00        2/10/0/12 gpu-a30-n[01-07],gpu-p100-n[01-05]
```
::::::

::: challenge

### Exercise 2: sinfo with options
What output does the following command produce?

```bash
sinfo -p gpuq -n sml-n02
```

Is there something missing in the output? How can we fix it?

:::

:::::: solution

Provides information of the specified node in the specified partition
```output
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
gpuq         up 2-00:00:00      0    n/a
```

The results says that node is not available, this is because there is no node called `sml-n02` in the regular partition. To fix it, we can either change the partition to `regular` or the node to something like `gpu-a30-n01`

```bash
sinfo -p regular -n sml-n02
```
```output
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
regular*     up 2-00:00:00      1    mix sml-n02
```
::::::


::: challenge

### Exercise 3: squeue with formatting option.

What output does the following command produce? Hint: check `man squeue`

```bash
squeue --format "%.18i %.9P %.8j %.8u %.8T %.10M %.6C %.13l %.7D %.14r %.12m %.18N %.8Q"
```

:::

:::::: solution

```output
JOBID      PARTITION   NAME    USER    STATE       TIME    CPUS    TIME_LIMIT    NODES      REASON        MIN_MEMORY        NODELIST      PRIORITY
11774748      gpuq    guppy    luo.q  PENDING       0:00     20    2-00:00:00       1 QOSMaxNodePerU         400G                        2060
11774747      gpuq    guppy    luo.q  PENDING       0:00     20    2-00:00:00       1 QOSMaxNodePerU         400G                        2060
11774746      gpuq    guppy    luo.q  PENDING       0:00     20    2-00:00:00       1 QOSMaxNodePerU         400G                        2060
11774744      gpuq    guppy    luo.q  RUNNING 1-05:28:48     20    2-00:00:00       1           None         400G        gpu-a30-n01     1366
11774745      gpuq    guppy    luo.q  RUNNING 1-05:41:49     20    2-00:00:00       1           None         400G        gpu-a30-n03     1360
          
```
::::::


::: challenge

### Exercise 4: sinfo with formatting option.

What output does the following command produce? Hint: you'll want to check the man page again!

```bash
sinfo --Node --Format "NodeList:21,Partition:11,StateLong:.11,CPUS:.5,Memory:.9,AllocMem:.9,Features:.20,CpusState:.14,GresUsed:.15"
```

:::

:::::: solution

```output
NODELIST             PARTITION        STATE CPUS   MEMORY ALLOCMEM      AVAIL_FEATURES CPUS(A/I/O/T)      GRES_USED
cl-n01               bigmem            idle  192  3093716        0   Cooperlake,AVX512   0/192/0/192          gpu:0
gpu-a10-n01          gpuq_intera       idle   48   256215        0GPU,Icelake,A10,AVX5     0/48/0/48.     gpu:A10:0
gpu-a30-n01          gpuq             mixed   96   511362   409600GPU,Icelake,A30,AVX5    20/76/0/96.     gpu:A30:1 
gpu-a30-n02          gpuq              idle   96   511362        0GPU,Icelake,A30,AVX5     0/96/0/96.     gpu:A30:0
gpu-a30-n03          gpuq             mixed   96   511362   409600GPU,Icelake,A30,AVX5    20/76/0/96.     gpu:A30:0
gpu-a30-n05          gpuq              idle   96   511362        0GPU,Icelake,A30,AVX5     0/96/0/96      gpu:A30:0
gpu-a30-n06          gpuq              idle   96   511362        0GPU,Icelake,A30,AVX5     0/96/0/96.     gpu:A30:0
gpu-a30-n07          gpuq              idle   96   511362        0GPU,Icelake,A30,AVX5     0/96/0/96.     gpu:A30:0
gpu-a100-n01         gpuq_large       mixed   96  1027457   819200GPU,Icelake,A100,AVX     2/94/0/96.     gpu:A100:1
gpu-a100-n02         gpuq_large       mixed   96  1027457   819200GPU,Icelake,A100,AVX     2/94/0/96.     gpu:A100:1
gpu-a100-n03         gpuq_large       mixed   96  1027457   819200GPU,Icelake,A100,AVX     2/94/0/96.     gpu:A100:1
```
::::::

::::::::::::::::::::::::::::::::::::: keypoints 

- Slurm commands are handy to view information about queued jobs, nodes and partitions
- You will commonly use `sbatch`, `squeue`, `salloc`, `sinfo` and `sacct`

::::::::::::::::::::::::::::::::::::::::::::::::

