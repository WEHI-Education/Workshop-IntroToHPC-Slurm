---
title: "Environment Modules"
teaching: 15
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do we load and unload software packages?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Load and use a software package.
- Explain how the shell environment changes when the module mechanism loads or unloads packages.

::::::::::::::::::::::::::::::::::::::::::::::::

On Milton, many softwares are installed but need to be loaded before you can run it.

## Why do we need Environment Modules?

- software incompatibilities
- versioning
- dependencies

Software incompatibility is a major headache for programmers. Sometimes the
presence (or absence) of a software package will break others that depend on
it. 

Two of the most famous examples are Python 2 and 3 and C compiler versions.
Python 3 famously provides a `python` command that conflicts with that provided
by Python 2. Software compiled against a newer version of the C libraries and
then used when they are not present will result in errors.

Software versioning is another common issue. A team might depend on a certain
package version for their research project - if the software version was to
change (for instance, if a package was updated), it might affect their results.
Having access to multiple software versions allow a set of researchers to
prevent software versioning issues from affecting their results.

Dependencies are where a particular software package (or even a particular
version) depends on having access to another software package (or even a
particular version of another software package). 

Environment modules are the solution to these problems. A _module_ is a
self-contained description of a software package -- it contains the
settings required to run a software package and, usually, encodes required
dependencies on other software packages.

The `module` command is used to interact with environment
modules. An additional subcommand is usually added to the command to specify
what you want to do. For a list of subcommands you can use `module -h` or
`module help`. As for all commands, you can access the full help on the _man_
pages with `man module`.

### Listing Available Modules

To see available software modules, use `module avail`:

```
$ module avail
```
```
------------------------------------------ /stornext/System/data/modulefiles/tools -------------------------------------------
apptainer/1.0.0            go/1.19.4                    mpich-slurm/3.4.1                   openmpi/4.1.1-slurm
apptainer/1.1.0            go/1.20.2                    mpich-slurm/3.4.2                   openMPI/4.1.4
aspera/3.5.4               groovy/4.0.0                 mpich/3.3                           openSSL/1.0.2r
aspera/3.9.1               gzip/1.10                    mpich/3.3.2                         openSSL/1.1.1b
aspera/3.9.6               hdf5-mpich/1.10.5_3.3        ncftp/3.2.6                         openSSL/1.1.1g
awscli/1.16py2.7           hpl/2.3                      netcdf_c/4.9.2                      openSSL/1.1.1k
awscli/1.16py3.7           icewm/2.8.0                  nextflow-tw-agent/0.5.0             openSSL/1.1.1n
awscli/1.22.89             iftop/1.0                    nextflow/22.04.5                    owncloud-client/2.3.3
awscli/2.1.25              ImageMagick/6.9.11-22        nextflow/22.10.4                    pandoc/2.14.2
awscli/2.5.2               ImageMagick/7.0.9-5          nf-core/2.7.2                       pandoc/2.19.2
axel/2.17.10               intel-ipp/2019.5.281         ninja/1.10.0                        pgsql/15.1
bazel/0.26.1               intel-mkl/2019.3.199         nmap-ncat/7.91                      pigz/2.6
bazel/1.2.1                intel-mpi/2019.3.199         nodejs/10.24.1                      pmix/2.2.5
binutils/2.35.2-gcc-4.8.5  intel-tbb/2019.3.199         nodejs/16.19.0                      pmix/3.2.3
binutils/2.35.2-gcc-9.1.0  intel_mkl_2019/2019.5.075    nodejs/17.9.1                       pmix/4.2.3
cluster-utils/18.08.1      intel_mpi_2019/2019.5.075    ocl-icd/2.3.1                       poetry/latest
cmake/3.25.1               ior-slurm/3.2.1mpich3.3      octave/6.4.0-gcc11.1.0              proj/4.9.3
CUnit/2.1-3                ior-slurm/3.2.1openMPI4.0.2  oneMKL/2022.1.0.223                 proj/6.3.2
curl/7.65.0                ior/3.2.1mpio4.0.1           openBLAS/0.3.6-gcc-9.1.0            proj/9.1.0
depot_tools/6c7b829        iozone/3.491                 openBLAS/0.3.21-gcc-11.1.0          qpdf/10.0.1
dotnet/2.1.809             julia/0.6.4                  openBLAS/0.3.21-gcc-11.1.0-skylake  quarto/1.1.189
dotnet/3.1.412             julia/1.0.1                  openBLAS/0.3.23-gcc-11.3.0          rclone/1.55.0
dotnet/6.0.408             julia/1.5.3                  openCV/2.4.13.6                     rstudio_singularity/1.0.0
doublecmd/0.9.10.gtk2      julia/1.8.5                  openCV/4.2.0                        slurm-contribs/20.11.5
dua-cli/2.17.8             libaio/0.3.111               openjdk/1.8.0                       snakemake/7.12.0
dua-cli/2.19.0             libiconv/1.16                openjdk/13.0.2                      sqlite/3.38.5
duckdb/0.6.1               lz4/1.9.3                    openjdk/14.0.2                      sqlite/3.40.0
elbencho/1.7-1cu10.1       mariadb-client/10.11.2       openjdk/15.0.2                      sqlite/3.40.1
evince/3.28.2              mariadb-connector-c/3.1.11   openjdk/16.0.1                      stornext/1.1
feh/3.6.3                  mariadb-connector-c/3.3.4    openjdk/17.0.2                      stubl/0.0.10
fftw/3.3.9                 maven/3.3.9                  openjdk/18.0.2                      tar/1.34
fio/3.16                   maven/3.9.1                  openMPI-slurm/4.1.0                 tcpdump/4.9.2
```

### Listing Currently Loaded Modules

You can use the `module list` command to see which modules you currently have
loaded in your environment. If you have no modules loaded, you will see a
message telling you so

```
$ module list
```
```
No Modulefiles Currently Loaded.
```


### Loading and Unloading Software

To load a software module, use `module load`. In this example we will use
Python 3.

Initially, Python 3 is not loaded. We can test this by using the `which`
command. `which` looks for programs the same way that Bash does, so we can use
it to tell us where a particular piece of software is stored.

```
$ which python3
/usr/bin/python3
python3 --version
Python 3.6.8
```

We can look at the available `Python 3` on Milton
```
$ module av python
---------------------------------------- /stornext/System/data/modulefiles/bioinf/its ----------------------------------------
python/2.7.18  python/3.5.3        python/3.7.0   python/3.8.3  python/3.9.5   python/3.11.2
python/3.5.1   python/3.6.5-intel  python/3.7.13  python/3.8.8  python/3.10.4
```

Now, we can load the `python 3.11.2` command with `module load`:

```
$ module load python/3.11.2
$ python3 --version
Python 3.11.2
```

Using `module unload` “un-loads” a module along with its dependencies. If we wanted to unload everything at once, we could run `module purge` (unloads everything).

Now, if you try to load a different version of Python 3, you will get an error.

```
module load python/3.8.8
Loading python/3.8.8
  ERROR: Module cannot be loaded due to a conflict.
    HINT: Might try "module unload python" first.
```
You will need to `module switch` to Python 3.8.8 instead of `module load`.
```
module switch  python/3.8.8
module list
Currently Loaded Modulefiles:
 1) python/3.8.8
```

::: challenge

### Exercise 1: What does `module whatis Python` do?

:::::: solution

Print information of modulefile(s)

::::::
:::

::: challenge

### Exercise 2: What does `module show Python` do?

:::::: solution

Show the changes loading the module does to your environment
```
-------------------------------------------------------------------
/stornext/System/data/modulefiles/bioinf/its/python/3.8.8:

module-whatis   {Python is a widely used high-level, general-purpose, interpreted, dynamic programming language. (v3.8.8)}
conflict        python
conflict        caffe2
conflict        anaconda2
conflict        anaconda3
conflict        CUDA8/caffe2
unsetenv        PYTHONHOME
setenv          PYTHON_INCLUDE_DIR /stornext/System/data/apps/python/python-3.8.8/include/python3.8
prepend-path    PATH /stornext/System/data/apps/python/python-3.8.8/bin
prepend-path    CPATH /stornext/System/data/apps/python/python-3.8.8/include/python3.8
prepend-path    MANPATH :/stornext/System/data/apps/python/python-3.8.8/share/man
prepend-path    LD_LIBRARY_PATH /stornext/System/data/apps/python/python-3.8.8/lib
```

::::::
:::

## What is $PATH?

`$PATH` is a special environment variable that controls where a UNIX system looks for software. Specifically `$PATH` is a list of directories (separated by `:`) that the OS searches through for a command before giving up and telling us it can't find it. As with all environment variables we can print it out using `echo`.

When we ran the `module load` command, it adds a directory to the beginning of our
`$PATH`. That is the way it "loads" software and also loads required software dependencies. The module loading process manipulates other special environment variables as well, including variables that influence where the
system looks for software libraries, and sometimes variables which
tell commercial software packages where to find license servers.

The module command also restores these shell environment variables to their previous state when a module is unloaded.


:::  callout

## Note

The login nodes are a _shared resource_. All users access a login node in order to check their files, submit jobs etc. If one or more users start to run computationally or I/O intensive tasks on the login node (such as forwarding of graphics, copying large files, running multicore jobs), then that will make operations difficult for everyone.

:::
::::::::::::::::::::::::::::::::::::: keypoints 

- Load software with `module load softwareName`.
- Unload software with `module unload`
- The module system handles software versioning and package conflicts for you automatically.
::::::::::::::::::::::::::::::::::::::::::::::::
