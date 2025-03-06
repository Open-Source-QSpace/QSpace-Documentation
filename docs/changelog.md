# Changlog

### 4.0.4 (2024-12-11)

- **Added:** Support for the integration with the high performance tensor
transpose (HPTT) library.
  Invoking the HPTT library produces ~10% performance improvement in the
  permutation operation for large tensors.

### 4.0.3 (2024-12-10)

- **Updated**: The built-in `permuteQS` receives performance improvements.
  The built-in permutation is optimized for a better incorporation of the
  OpenMP parallelization. The new implementation is ~20% faster than the
  previous version.

### 4.0.2 (2024-11-26)

- **Added:** `fuse` function for tensor index fusion.
- **Added:** `decomp` function for various principal coponents decomposition.
- **Fixed:** Update `oplus` function to accommodate the trailing OM index.

### 4.0.1 (2024-10-12)

- **Added:** Create Metadata information after compilation.
- **Added:** Welcome information for deployed applications.
- **Added:** `configure` script and `osqs` entrance application.
- **Added:** `osqs` command line tool in MATLAB interative interface.

### 4.0.0 (2024-10-07)

- **Added:** One-line compilation script for macOS and Linux.
- **Added:** Environment presets for macOS and ASC HPC clusters.
- **Fixed:** Optimize hostname warning message.
- **Updated:** Improved `RC_STORE` strategy in startup.m.

&nbsp;
