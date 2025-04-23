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
dependencies on other software packages. HPC facilities will often have their
own optimised versions of some software, so modules also make it easier to use
these versions.

## `module` command

The `module` command is used to interact with environment
modules. An additional subcommand is usually added to the command to specify
what you want to do. For a list of subcommands you can use `module -h` or
`module help`. As for all commands, you can access the full help on the _man_
pages with `man module`.

### Listing Available Modules

To see available software modules, use `module avail`:

```bash
module avail
```
```output
--------------------------------------------------------------- /stornext/System/data/modulefiles/rhel/9/base/bioinf ----------------------------------------------------------------
bcftools/1.19         canu/2.2              deeptools/3.5.5  gatk/4.6.0.0   IGV/2.18.0        nanopolish/0.14.0   plink/1.9          spaceranger/3.1.1  ucsc-tools/362  
bcftools/1.20         cellranger-arc/2.0.2  diamond/2.1.10   gridss/2.13.2  MACS2/2.2.9.1     ncbi-blast/2.16.0   plink2/2.00        spaceranger/3.1.2  varscan/2.4.6   
bcftools/1.21         cellranger/8.0.1      dorado/0.6.0     hisat2/2.2.1   MACS3/3.0.1       nf-core/2.14.1      salmon/1.10.2      sra-toolkit/3.1.0  
bcl-convert/3.10.5    cellranger/9.0.0      dorado/0.7.3     homer/4.11     mageck/0.5.9.5    nix/fix             samtools/1.19.2    STAR/2.7.11b       
bcl2fastq/2.20.0.422  cellsnp-lite/1.2.3    dorado/0.9.0     homer/5.1      meme/5.5.6        nix/latest          samtools/1.20      subread/2.0.6      
bedtools/2.31.1       cutadapt/4.8          ensembl-vep/112  htslib/1.19.1  minimap2/2.28     picard-tools/3.1.1  samtools/1.21      trimgalore/0.6.10  
bowtie2/2.5.3         cutadapt/4.9          fastqc/0.12.1    htslib/1.20    MMseqs2/16-747c6  picard-tools/3.2.0  seqmonk/1.48.1     trimmomatic/0.39   
bwa/0.7.17            deeptools/3.5.1       gatk/4.2.5.0     htslib/1.21    MultiQC/1.24      picard-tools/3.3.0  spaceranger/2.1.1  ucsc-tools/331     

--------------------------------------------------------------- /stornext/System/data/modulefiles/rhel/9/base/nvidia ----------------------------------------------------------------
CUDA/11.8  CUDA/12.1  CUDA/12.3  CUDA/12.4  cuDNN/8.9.7.29-11  cuDNN/8.9.7.29-12  nvtop/3.1.0  TensorRT/8.6.1.6-11  TensorRT/8.6.1.6-12  

-------------------------------------------------------------- /stornext/System/data/modulefiles/rhel/9/base/structbio --------------------------------------------------------------
alphafold/2.3.2         AreTomo/3.0.0_CUDA12.1  CryoPROS/1.0          DESRES/2023-4       gromacs/2024.2_CUDA12.4    patchdock/1.3             relion/5.0_CUDA12.1                 
alphafold/3.0.0         autodock/4.2.6          cryosamba/1.0         dials/3.9.0         H5toXDS/1.1.0              phenix/1.21.2-5419        rosetta/3.14                        
alphafold/3.0.1         autoPROC/20240710       ctffind/4.1.14        dssp/4.4.11         haddock3/2024.10.0b7       PRosettaC/d53ed49         RoseTTAFold-All-Atom/1.3-nosignalp  
AlphaLink/1.0           bsoft/2.1.3             ctffind/4.1.14-MKL    EMAN2/2.99.47       IMOD/5.0.2                 pyem/0.63                 spIsoNet/1.0                        
Amber/24                ccp4/7.1                ctffind/5.0.5         EMReady/2.0         motioncor2/1.6.4_CUDA11.8  pymol/2.5.0               topaz/0.2.5a                        
AreTomo/1.1.2_CUDA11.8  ccp4/8.0                dalilite/5.0.1        EPU_Group_AFIS/0.3  motioncor2/1.6.4_CUDA12.1  pymol/3.0.0               warp/2.0.0                          
AreTomo/1.1.2_CUDA12.1  chimerax/1.9            dectris-neggia/1.2.0  FastFold/0.2.0      motioncor3/1.0.1_CUDA11.8  relion/4.0.1_CUDA12.1     XDS/20240630                        
AreTomo/1.3.4_CUDA11.8  crYOLO/1.9.9            deepEMhancer/0.16     gromacs/2024.2      motioncor3/1.0.1_CUDA12.1  relion/5.0-beta_CUDA12.1  xdsgui/20231229                     

---------------------------------------------------------------- /stornext/System/data/modulefiles/rhel/9/base/tools ----------------------------------------------------------------
7zip/24.08                 evince/3.28.2          JAGS/4.3.2                   nextflow/24.04.2             oras/1.2.0                   R/4.1.3               squashfuse/0.5.0      
apptainer/1.2.5            fftw/3.3.10            jobstats/1.0.0               nextflow/24.10.5             owncloud-client/5.3.1.14018  R/4.2.3               stornext/1.1          
apptainer/1.2.5-compat     flexiblas/3.4.2        julia/1.10.4                 ninja/1.11.1                 pandoc/3.2                   R/4.3.3               tar/1.35              
apptainer/1.3.3            gcc/14.2               jupyter/6.5.7                nmap/7.94                    parallel/20240722            R/4.4.1               texlive/2023          
apptainer/1.3.5            gcloud-sdk/496.0.0     jupyter/latest               nodejs/20.16.0               pcre2/10.42                  R/4.4.2               texlive/2024          
awscli/2.3.1               gdal/3.9.0             libjpeg-turbo/3.0.2          omero-py/5.19.6              perl/5.40.0                  R/4.5.0               turbovnc/3.1.1        
blis/0.9.0-omp-intel       geos/3.12.1            libpng/1.6.43                oneMKL/2024.0.0.49673        perl/5.40.0-threads          R/flexiblas/4.3.3     uv/0.5.31             
blis/0.9.0-pt-intel        git/2.46.0             libtiff/4.6.0                openbabel/2.4.0              pgsql/15.1                   R/flexiblas/4.4.1     uv/0.6.12             
blis/0.9.0-serial-generic  glpk/4.65              mariadb-connector-c/3.3.10   openBLAS/0.3.26-haswell      pigz/2.8                     R/flexiblas/4.4.2     vast-trino/420        
blis/0.9.0-serial-intel    glpk/5.0               mediaflux-data-mover/1.2.11  openBLAS/0.3.26-omp-haswell  postgresql/16.4              R/flexiblas/4.5.0     virtualgl/3.1.1       
boost/1.72.0               gnuplot/6.0.1          micromamba/latest            openBLAS/0.3.26-pt-haswell   proj/9.4.0                   rc-tools/1.0          virtualgl/3.1.2       
boost/1.79.0               go/1.13.15             miniconda3/latest            openBLAS/0.3.26-serial       protobuf-c/1.5.0             rclone/1.67.0         websockify/0.11.0     
boost/1.84.0               go/1.21.6              miniwdl/1.12.1               openCV/4.10.0                protobuf/3.14.0              rsync/3.3.0           xdotool/3.20211022.1  
bzip2/1.0.8                GraphicsMagick/1.3.45  netcdf/4.9.2                 openjdk/18.0.2               protobuf/3.28.1              singularity/4.1.3     Xvfb/1.20.11          
cairo/1.19.0               hdf5/1.12.3            nextflow-tw-agent/0.5.0      openjdk/21.0.2               python/3.11.8                singularity/4.1.5     xz/5.4.6              
cmake/3.30.2               hdf5/1.14.4-3          nextflow-tw-cli/0.8.0        openjdk/22.0.2               python/3.12.4                snakemake/8.11.3      zlib/1.3.1            
curl/8.6.0                 icewm/3.6.0            nextflow/22.10.4             openmpi/4.1.6                python/3.13.0                spack/0.21.2          
dua-cli/2.29.0             ImageMagick/7.1.1      nextflow/23.10.0             openssl/3.2.1                quarto/1.4.554               squashfs-tools/1.3.1  
```

### Listing Currently Loaded Modules

You can use the `module list` command to see which modules you currently have
loaded in your environment. If you have no modules loaded, you will see a
message telling you so

```bash
module list
```
```output
No Modulefiles Currently Loaded.
```


### Loading and Unloading Software

To load a software module, use `module load`. In this example we will use
Python 3.

Initially, Python 3 is not loaded. We can test this by using the `which`
command. `which` looks for programs the same way that Bash does, so we can use
it to tell us where a particular piece of software is stored.

```bash
which python3
```
```output
/usr/bin/python3
```
```bash
python3 --version
```
```output
Python 3.9.21
```

We can look at the available `python` modules on Milton
```bash
module avail python
```
```output
---------------------------------------------------------------- /stornext/System/data/modulefiles/rhel/9/base/tools ----------------------------------------------------------------
python/3.11.8  python/3.12.4  python/3.13.0  
```

Now, we can load the `python 3.11.8` command with `module load`:

```bash
module load python/3.11.8
python3 --version
```
```output
Python 3.11.8
```

Using `module unload` “un-loads” a module along with its dependencies. If we wanted to unload everything at once, we could run `module purge` (unloads everything).

Now, if you already have a Python module loaded, and you try to load a different version of Python 3, you will get an error.

```bash
module load python/3.12.4
```
```output
Loading python/3.12.4
  ERROR: Module cannot be loaded due to a conflict.
    HINT: Might try "module unload python" first.
```
You will need to `module switch` to Python 3.12.4 instead of `module load`.
```bash
module switch  python/3.12.4
module list
```
```output
Currently Loaded Modulefiles:
 1) python/3.12.4
```

::: challenge


### Exercise 1: What does `module whatis python` do?

:::::: solution

Print information of modulefile(s)

::::::
:::

::: challenge

### Exercise 2: What does `module show python` do?

:::::: solution

Show the changes loading the module does to your environment
```bash
module show python
```
```output
-------------------------------------------------------------------
/stornext/System/data/modulefiles/rhel/9/base/tools/python/3.11.8:

module-whatis   {a widely used high-level, general-purpose, interpreted, dynamic programming language. (v3.11.8)}
conflict        python
unsetenv        PYTHONHOME
setenv          PYTHON_INCLUDE_DIR /stornext/System/data/software/rhel/9/base/tools/python/3.11.8/include/python3.11
prepend-path    PATH /stornext/System/data/software/rhel/9/base/tools/python/3.11.8/bin
prepend-path    CPATH /stornext/System/data/software/rhel/9/base/tools/python/3.11.8/include/python3.11
prepend-path    MANPATH :/stornext/System/data/software/rhel/9/base/tools/python/3.11.8/share/man
prepend-path    LD_LIBRARY_PATH /stornext/System/data/software/rhel/9/base/tools/python/3.11.8/lib
-------------------------------------------------------------------
```

::::::
:::

## What is `$PATH`?

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
- Unload software with `module unload` or `module purge`.
- The module system handles software versioning and package conflicts for you automatically.
::::::::::::::::::::::::::::::::::::::::::::::::
