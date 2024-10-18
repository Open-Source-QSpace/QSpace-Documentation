# Installation on macOS System

This document provides a detailed guide to installing the QSpace library on macOS, tailored to support users with varying levels of programming expertise. The installation process includes setting up MATLAB, configuring the appropriate compiler via Xcode, installing Homebrew, and cloning the QSpace repository before compiling the library. For advanced customizations or troubleshooting, please refer to [TODO].

!!! note

    This installation guide is specific for the community edition ([OSQSpace](https://github.com/Open-Source-QSpace/OSQSpace)). For the installation of the standard edition, please refer to the README and relevant setup scripts under the system directory of the [QSpace4u](https://bitbucket.org/qspace4u/qspace-v4-pub) project.

### Install MATLAB (Version 2020b or Above)

MATLAB is essential for QSpace as it interfaces with the library's routines. It is advised to install MATLAB version 2020b or newer to ensure compatibility with QSpace's functionalities. Versions from 2018a to 2020a may work but are not actively supported.

To install MATLAB on macOS:
1. Visit the [MATLAB download page](https://www.mathworks.com/products/matlab.html) and select the version suitable for macOS. Download the installer.
2. Open the downloaded file and follow the on-screen instructions to complete the installation.

### Choose MATLAB Architecture Based on CPU Architecture

With macOS, it is important to match MATLAB's architecture with your CPU architecture to ensure optimal performance and compatibility:

- For Intel-based Macs, use the standard MATLAB installer for macOS.
- For Apple Silicon (M-series chips), choose the MATLAB version compiled for ARM architecture, available starting from the 2023b release.

!!! note
    
    It is also possible to run the Intel version of MATLAB (e.g. versions earlier than 2023b) on Apple Silicon Macs using Rosetta 2 emulation. QSpace presets support this functionality. However, it is still recommended to use the native ARM version for best compatibility and performance.

### Setup Clang Compiler via Xcode

QSpace requires a C/C++ compiler, and on macOS, Clang is the standard. To set up Clang, install Xcode from the Mac App Store. After installation, open Xcode and install additional required components when prompted, which includes the Clang compiler. To verify that the Clang compiler is ready, open a terminal and run:

```bash
clang --version
```

This will display the Clang version, indicating that it is installed and ready to use.

### Install Homebrew

Homebrew is a package manager for macOS that simplifies the installation of software and libraries. It is important to ensure that Homebrew is installed correctly according to your Mac's CPU architecture to manage dependencies efficiently.

To install Homebrew on macOS, open a terminal and run the following commands:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Regardless of your CPU architecture (Intel or Apple Silicon), the installation command for Homebrew is the same. This script will automatically detect your macOS architecture and install the correct version of Homebrew.

The installer will guide you through the necessary steps to complete the installation. If additional actions are required (such as adding Homebrew to your path), the installer will provide the specific commands. After installation, you can verify that Homebrew is installed correctly via:

```bash
brew --version
```

This command will display the installed version of Homebrew, confirming that it is ready to use.

If you are using an Apple Silicon Mac and need to run software that is only available for Intel architecture, you can set up an additional Homebrew installation under the Rosetta 2 emulation layer. This is necessary if you hope to run Intel-compiled MATLAB with Intel-compiled QSpace binaries on an Apple Silicon Mac.

To do this, you need to prefix your Homebrew commands with `arch -x86_64` to switch to the Intel architecture environment:

```bash
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This allows you to manage and install packages specifically for Intel architecture on Apple Silicon Macs.

The compilation scripts carried by QSpace will handle the dependencies as long as Homebrew is installed correctly.

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
