# Installation on Linux

## Install MATLAB {#sec:linux_ml}
QSpace is a library running on MATLAB, so one needs a MATLAB
installation. For the current QSpace distribution (v4.0),
we recommend to use MATLAB R2020b or later, because of MEX compilers.
Older MATLAB versions might work, but no guarantee.

## Install `gmp` and `mpfr` {#sec:linux_gmp_mpfr}

QSpace uses `gmp` and `mpfr`, multiprecision arithmetics libraries, in
generating and manipulating the Clebsch-Gordan coefficient tensors.
However, a standard installation of Linux may not have `gmp` and `mpfr`
installed.

### Install `gmp` {#sec:linux_gmp}

If you are not sure whether `gmp` is installed in your device, type in
the terminal:

```
dpkg -s libgmp-dev
```

If the command works, showing the installed version of `gmp`, then you
can skip the rest of this subsection and move forward to [Install `mpfr`](#sec:linux_mpfr).

When the terminal says `package 'libgmp-dev' is not installed`, then you
can install `gmp` by typing the following command.

```
sudo apt-get install libgmp-dev
```

### Install `mpfr` {#sec:linux_mpfr}

If you are not sure whether `mpfr` is installed in your device, type in
the terminal:


```
dpkg -s libmpfr-dev
```

If the command works, showing the installed version of `mpfr`, then you
can skip the rest of this subsection and move forward to [Retrieve QSpace files](#sec:linux_qs).

When the terminal says `package 'libmpfr-dev' is not installed`, then
you can install `mpfr` by typing the following command.

```
sudo apt-get install libmpfr-dev
```

## Retrieve QSpace files {#sec:linux_qs}

There is a separate [Git
repository](https://bitbucket.org/qspace4u/qspace-v4-pub) for the
QSpace codes for Linux. If you know how to use Git, then you can
proceed with cloning the repository. If you don't know, then visit the
repository webpage and click Clone, which will lead you a dialogue
window showing the command:


```
git clone https://bitbucket.org/qspace4u/qspace-v4-pub.git
```

Then go to a directory under which the copied Git repository data will
be stored. Move to the directory, and run the command above in your
terminal. Then the repository will be cloned to a sub-directory under
your current working directory.

## MEX-compile source codes

The QSpace distribution for Linux does not include MEX binaries,
contrary to that for macOS, so one needs to compile C++ source codes.
For this one needs to install `gcc` or, if your system uses a module
system, load a `gcc` module. One can check which versions of `gcc` are
supported by a specific MATLAB version
[here](https://www.mathworks.com/support/requirements/previous-releases.html).

If you are not sure whether `gcc` is installed in your device, type in
the terminal:

```
gcc –version
```

If the command works, showing the installed version of `gcc`, then move
forward to the next paragraph. If the command does not show the
installed version of `gcc`, then you can install `gcc` by typing the
following command.

```
sudo apt install gcc
```

If the `gcc` version installed in your device is not supported by
MATLAB, you have to install the supported version of `gcc`. As an
example, If the `gcc` of version 11 is installed and MATLAB supports
only the `gcc` of version 9, you can install `gcc` of version 9 by
typing following commands.

```
sudo apt install build-essential
```

```
sudo apt-get install -y gcc-9
```

```
cd /usr/bin
```

```
sudo rm gcc
```

```
sudo ln -s gcc-9 gcc
```

To check the current version of `gcc`, type in the terminal:

```
gcc –version
```

If you want to roll back to the `gcc` of version 11, type in the
terminal:

```
cd /usr/bin```

```
sudo rm gcc```

```
sudo ln -s gcc-11 gcc
```

To check the current version of `gcc`, type in the terminal:

```
gcc –version
```

Our QSpaceTutorial package offers a simple way to compile the source
codes. First, open a MATLAB session. Then run the function
`Util/compile.m`. That's it!

The remaining step before using the `QSpace` library is to set
environment variables and paths; see [Set environment variables and paths](#sec:startup).

# Set environment variables and paths {#sec:startup}

## Set `RC_STORE`

`RC_STORE` is the only environment variable that needs to be set by
users, to execute the QSpace functions (both `.m` and `MEX`). This
variable specifies the paths to place the database of Clebsch--Gordan
coefficient tensor (CGT) data, which is generated and read on the fly
during calculations. Those CGT data can be reused for different
calculations, which provides a great computational advantage.

`RC_STORE` can be defined by multiple paths glued with `:`, e.g.,
`path1:path2:path3`. When there are $n$ paths, then the functions look
up CGT data from the first path, then the second, and so on. If the CGT
data of interest are not created yet, then QSpace generates and store
them in the last path. When $n > 1$, the paths except for the last are
read-only.

Since CGTs are used to define the symmetry multiplet basis to represent
physical tensors, it is important to have consistent CGT database.
Especially, when running on a computing cluster, the database
consistency among different jobs is essential. Therefore, a recommended
choice of `RC_STORE` for clusters is `path1:path2`, where `path1`
is the path for the "global" database to be looked up by all cluster
jobs and `path2` is a job-dependent path that refers to the "local"
increment specific to a job. If the global database is large enough, the
local increment will remain small. On the other hand, for laptops and
desktops, such distinction might be an overkill; one can simply set
`RC_STORE` as a single path.

## Modify `startup.m`

`startup.m` is a script that is first executed upon starting up a MATLAB
session, so that important environment variables and paths are set
before use. This `QSpaceTutorial` as well as `MuNRG` have own
`startup.m` that should be modified by users regarding those environment
variables. Mostly such variables are for paths that depend on computing
systems. Please follow the instruction in `startup.m` to set the
environment variables properly.

# Troubleshooting

In the following, some known issues regarding QSpace and their
workarounds are given.

## make: command not found

When you try to compile QSpace, MATLAB might show the following error
message.

```
/bin/bash: line 1: make: command not found
```

This error occurs if Linux does not have `make`, a tool which controls
the generation of executables from source files, installed.

To resolve this error, install `make` by typing the following command.

```
sudo apt install make
```

## Invalid MEX file, GLIBCXX not found

When you try to use QSpace, MATLAB might complain that the MEX files
are not valid and show the following error message.

```
Invalid MEX-file
‘/home/Document/MATLAB/QSpace_v4.0/bin/getSymStates.mexa64’:
/usr/local/MATLAB/R2022a/bin/glnxa64/../../sys/os/glnxa64/libstdc++.so.6: version
‘GLIBCXX_3.4.29’ not found (required by
/home/Document/MATLAB/QSpace_v4.0/bin/getSymStates.mexa64)
```

To resolve this error, try following commands in the terminal.

```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test`
```

```
sudo apt-get update
```

```
sudo apt-get install gcc-4.9
```

```
sudo apt-get upgrade libstdc++6
```

Then, recomplie the sourse code by running the function `Util/compile.m`
again.

If MATLAB still complains, then copy and paste the file `libstdc++.so.6`
at the directory `/usr/local/MATLAB/R2022a/sys/os/glnxa64` by using the following a
single command.

```
sudo cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/local/MATLAB/R2022a/sys/os/glnxa64/
```

Note that the directory depends on your MATLAB version, e.g., if you are
using MATLAB R2021b, then type the following single command instead.

```
sudo cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/local/MATLAB/R2021b/sys/os/glnxa64/
```

Then, recomplie the sourse code by running the function `Util/compile.m`
again.