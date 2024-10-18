# Installation on Linux Platforms

This document provides a detailed guide to installing the QSpace library on Linux systems, tailored to support users with varying levels of programming expertise. The installation process includes setting up MATLAB, ensuring the appropriate version of gcc is used, managing dependencies, cloning the QSpace repository, and compiling the library. For advanced customizations or troubleshooting, please refer to [TODO]

!!! note

    This installation guide is specific for community edition ([OSQSpace](https://github.com/Open-Source-QSpace/OSQSpace)). For the installation of the standard edition, please refer to the README and relevant setup scripts under system directory of the [QSpace4u](https://bitbucket.org/qspace4u/qspace-v4-pub) project.

### Install MATLAB (Version 2020b or Above)

MATLAB is critical for QSpace as it provides an interface through which the library's routines are executed. It is recommended to install MATLAB version 2020b or newer to guarantee compatibility with QSpace’s functions. MATLAB 2018a to 2020a may also work, but no active support is provided for these versions.

To install MATLAB on Linux, download the appropriate version of MATLAB from the [MATLAB download page](https://www.mathworks.com/products/matlab.html). Ensure you are downloading a version for Linux platform.

Next, navigate to your download folder, make the downloaded script executable, and initiate the installation process. You may follow the commands:

  ```bash
  chmod +x matlab_R20XXx_glnxa64.bin
  ./matlab_R20XXx_glnxa64.bin
  ```
Then, follow the on-screen instructions to complete the installation. If MATLAB environment is managed through a module system, you can typically load the MATLAB module using:

  ```bash
  module load matlab/R20XXx
  ```

In this scenario, please ensure that the appropriate module is loaded before proceeding with any QSpace related workflow. To verify a successful installation, open your terminal and execute:

  ```bash
  which matlab
  ```

This should return the path to the MATLAB executable, confirming that MATLAB is ready for use. This path will be set as the `MATLAB_ROOT` environment variable and is vital for the QSpace installation and workflows.

### Prepare gcc Compiler (Version 9.x or Below)

QSpace requires gcc for compilation. The version of gcc should be compatible with MATLAB. MATLAB 2020b and later versions support gcc 9.x and previous versions. An old MATLAB and an overly new gcc may cause unexpected compatibility issues. Please refer to [Supported Compilers](https://www.mathworks.com/support/requirements/previous-releases.html) page for the supported gcc versions for a specific MATLAB version.

Before proceeding with the installation, ensure that the correct version of gcc is installed on your system. Check your current gcc version by running:

  ```bash
  gcc --version
  ```

If the installed version is not supported by MATLAB, you may need to install the appropriate version. For instance, you can install gcc-9.5.0 using your Linux distribution's package manager. For distributions using `apt`, such as Ubuntu, run the following commands:

  ```bash
  sudo apt install gcc-9 g++-9
  ```

To avoid version conflicts, especially if other versions of gcc are already installed, configure your system to use gcc-9.5.0 as the default for this installation session:

  ```bash
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9
  ```

The command includes `60` to assign a priority to the `gcc-9` version, making it a preferred choice if multiple GCC versions are installed. The `--slave` part ensures that when `gcc-9` is selected as the default GCC compiler, `g++-9` automatically becomes the default G++ compiler, maintaining consistency between the C and C++ compilers.

### Manage Dependencies

QSpace depends on several libraries, including GMP, MPFR, and OpenMP, which are essential for high-precision arithmetic and efficient multi-threading.

**Dependency Installation:** Install these libraries through your package manager:
  ```bash
  sudo apt install libgmp-dev libmpfr-dev libomp-dev
  ```

**Checking Library Installation:** Verify the installation of these libraries by querying the package manager. For instance:
  ```bash
  dpkg -l | grep libgmp
  ```

These libraries should rest in the default system directories, such as `/usr/lib` or `/usr/local/lib`. Otherwise, you may need to adjust `LD_LIBRARY_PATH` environment variable to include the directories where the libraries are installed.

### Clone the QSpace Repository

Clone the repository to acquire the source code necessary for installation:

```bash
git clone git@github.com:Open-Source-QSpace/OSQSpace.git
```

Ensure that your SSH keys are configured correctly with GitHub for a smooth cloning process.

### Compile the QSpace Library

Navigate to the repository directory and execute the configuration and compilation scripts:

```bash
cd system && source configure && ./compile.sh
```

The `configure` script sets up a command line tool `osqs` and the installation directory of QSpace library. The compile script calls the environment setup script before compiling the QSpace library. Customizations are available via setting `QS_CONFIG_ML_SH` environment variable pointing to a custom environment setup script.

&nbsp;
