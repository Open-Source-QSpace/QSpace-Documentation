# Installation on macOS

## Install MATLAB {#sec:mac_ml}

QSpace is a library running on MATLAB, so we need a MATLAB
installation. For the current QSpace distribution (v4.0),
we recommend to use MATLAB R2020b or later, since the provided binaries
are compiled with R2020b. Older MATLAB versions might work, but no
guarantee.

!!! note

    MATLAB has a native Apple Silicon version since 2023b. However, the QSpace 
    binaries for macOS are compiled with intel x86_64 architechture. Therefore,
    QSpace is currently incompatible with the native Apple Silicon MATLAB.
    For users of MATLAB 2023b or newer, please install the version 
    compiled for intel processors and run the MATLAB over Rosetta 2.

## Install `gmp` {#sec:mac_gmp}

QSpace uses `gmp`, a multiprecision arithmetics library, in generating
and manipulating the Clebsch-Gordan coefficient tensors. However, a
standard installation of macOS may not have `gmp` installed. If you are
not sure whether it's installed in your device, type in the terminal:

```
brew info gmp
```

If the command works, showing the installed version of `gmp`, then you
can skip the rest of this subsection and move forward to [Retrieve QSpace files](#sec:mac_qs).

When the command above fails, there are two possibilities.

-   If the terminal says `command not found: brew`, then `homebrew` is
    missing. You can install `homebrew` by typing the following as a
    single command in the terminal.

    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

    Then take the next step to install `gmp`.

-   If the terminal says "Error: No available formula or cask", then
    `homebrew` is installed, while `gmp` is not. You can simply install
    `gmp` by the terminal command

    ```
    brew install gmp
    ```

    For more information, refer to [here](https://formulae.brew.sh/formula/gmp).

## Retrieve QSpace files {#sec:mac_qs}

There is a separate [Git
repository](https://bitbucket.org/qspace4u/qspace-v4-osx12-monterey) for
the QSpace codes for macOS. If you know how to use Git, then you can
proceed with cloning the repository. If you don't know, then visit the
repository webpage and click "Clone", which will lead you a dialogue
window showing the command:

```
git clone https://bitbucket.org/qspace4u/qspace-v4-osx12-monterey.git
```

Then go to a directory under which the copied Git repository data will
be stored. Move to the directory, and run the command above in your
terminal. Then the repository will be cloned to a sub-directory under
your current working directory.

The QSpace distribution for macOS already includes pre-compiled MEX
binaries (`.mexmaci64`), so the current QSpace installation is almost
ready to use. (Since the MEX-compilation in macOS is a bit more
involved compared to Linux, Andreas W. kindly provides the binaries
together.) The remaining step is to set environment variables and paths;
see [Set environment variables and paths](#sec:startup).

## Set environment variables and paths {#sec:startup}

### Set `RC_STORE`

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

### Modify `startup.m`

`startup.m` is a script that is first executed upon starting up a MATLAB
session, so that important environment variables and paths are set
before use. This `QSpaceTutorial` as well as `MuNRG` have own
`startup.m` that should be modified by users regarding those environment
variables. Mostly such variables are for paths that depend on computing
systems. Please follow the instruction in `startup.m` to set the
environment variables properly.

## Troubleshooting

In the following, some known issues regarding QSpace and their
workarounds are given.

### MEX files cannot be opened because the developer cannot be verified

When you try to use QSpace, some higher version of macOS might
complain that the developer of the MEX function binaries not verified,
so it cannot run them. One can solve this issue as follows. First, type
the command

```
sudo xattr -r -d com.apple.quarantine ~/Documents/MATLAB/QSpace_v4.0
sudo find ~/Documents/MATLAB/QSpace_v4.0 -name \`$\ast$`.mexmaci64 -exec spctl –add {} \;
```

Note that the last command line is a single line so make the command as
a single line if it is divided. For more information, refer to
[here](http://www.fieldtriptoolbox.org/faq/mexmaci64_cannot_be_opened_because_the_developer_cannot_be_verified/).

### Invalid MEX file, Library not loaded

If your Mac uses the Apple silicon chip, such as the M1 or M2 chips,
MATLAB might complain that the MEX files are not valid and show the
following error message.

```
Invalid MEX-file
‘~/Documents/MATLAB/QSpace_v4.0/bin/getSymStates.mexa64’:
dlopen(~/MATLAB/QSpace_v4.0/bin/getSymStates.mexa64, 0x0006): Library not loaded: /usr/local/opt/gmp/lib/libgmp.10.dylib
Referenced from: ~/Documents/MATLAB/QSpace_v4.0/bin/getSymStates.mexa64
Reason: tried: ’/usr/local/opt/gmp/lib/libgmp.10.dylib’ (mach-o file, but is an incompatible architecture (have ’arm64’, need ’x86_64’)), ’/usr/local/lib/libgmp.10.dylib’ (mach-o file, but is an incompatible architecture (have ’arm64’, need ’x86_64’)), ’/usr/lib/libgmp.10.dylib’ (no such file)`
```

It happens because the Apple silicon chips are ARM64 CPUs while the
`MEX` file is compiled for a x86-64 CPU.

To resolve this error, download the `gmp.zip`
[here](https://syncandshare.lrz.de/getlink/fiL5RYGXzwu79GEYYtToHj/gmp.zip)
and move the folder `gmp` to `~/Documents`. Then, type the following
command.

```
ln -s ~/Documents/gmp /usr/local/opt/
```

This command generates a symbolic link to `gmp`. To remove the link,
type the following command.

```
rm /usr/local/opt/gmp
```

If macOS complains that `libgmp.10.dylib` is not verified, then try the
following commands on the terminal:

```
sudo xattr -r -d com.apple.quarantine /usr/local/opt/gmp/lib/
sudo find /usr/local/opt/gmp/lib/ -name \`$\ast$`.dylib -exec spctl –add {} \;
```

If macOS still complains, go to `System Settings...` $\rightarrow$
`Security & Privacy` $\rightarrow$ click 'Open Anyway' for
`libgmp.10.dylib`.

&nbsp;
