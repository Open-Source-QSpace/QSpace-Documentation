# Customization of Environment Variables

This document provides detailed explanations of the environment variables used in the QSpace library, outlining their purposes and how to properly configure them. These environment variables are crucial for ensuring that the QSpace library functions correctly and integrates seamlessly with MATLAB and system-specific resources. Preconfigured settings are available for users on High-Performance Computing (HPC) clusters at the Arnold-Sommerfeld Center and macOS systems. Users on other platforms should configure these variables manually using `env_custom.sh` prior to compilation.

## Environment Variables Explanation

### `OSQS`: QSpace Installation Directory
- **Description**: This variable specifies the installation directory of the QSpace library where the main library files are located.
- **Typical Usage**: Set this to the directory where you have cloned or extracted QSpace.

### `MATLAB_ROOT`: MATLAB Installation Directory
- **Description**: This points to the installation directory of the MATLAB installation on your system.
- **Notes**: On systems where MATLAB is managed through environment modules, this variable might be set automatically when you load a MATLAB module.

### `STARTUP`: QSpace Startup Location
- **Description**: This environment variable indicates the location of the `startup.m` file, which is a MATLAB script that sets up paths and initialization settings necessary for QSpace.
- **Typical Usage**: It is typically set to the same directory as `OSQS`, as the `startup.m` file is usually located within the root directory of QSpace.

### `LMA`: Local MATLAB Data Directory
- **Description**: Specifies the directory for local MATLAB data used by QSpace.
- **Purpose**: This directory is used to store MATLAB-specific data that needs to be accessed frequently by the QSpace library.

### `RC_STORE`: Clebsch-Gordan Coefficient Storage
- **Importance**: This is a crucial variable for the operation of QSpace, particularly for computations involving SU(N) groups where N>1.
- **Description**: Specifies the location where the Clebsch-Gordan coefficients are stored. These coefficients are essential for the mathematical operations performed by QSpace.
- **Configuration Note**: Ensure that this directory is properly set to a location where the system has read and write permissions, as these coefficients may need to be updated or modified.

### `RC_SYNC`: Clebsch-Gordan Coefficient Lock Files
- **Description**: Indicates the directory where lock files associated with the Clebsch-Gordan coefficients are stored.
- **Purpose**: These lock files prevent multiple instances of QSpace from interfering with each other when accessing the Clebsch-Gordan coefficients, thus ensuring data integrity and consistency.

## Platform-Specific Presets

- **HPC Clusters at Arnold-Sommerfeld Center**: For users operating within these HPC environments, preset configurations are provided which automatically set these environment variables appropriately. Users should refer to the specific cluster documentation or system admin for details.
- **macOS Systems**: There are also presets available for macOS users which simplify the setup process by automatically configuring these environment variables to work optimally with typical macOS setups.

## Setting Up on Other Platforms

For users operating on platforms other than those mentioned, the `env_custom.sh` script should be utilized to set up these environment variables before compiling the QSpace library. This script allows users to manually specify the values of these variables tailored to their specific system configuration and preferences.
