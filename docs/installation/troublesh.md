# Frequently Encountered Errors

## libstdc++.so.6: version ‘GLIBCXX_3.4.29’ not found

This error typically indicates a mismatch between the version of the libstdc++ library included with MATLAB and the version required by the gcc compiler used. The symbol ‘GLIBCXX_3.4.29’ specifically belongs to gcc version 11, which is incompatible with the version of libstdc++ that MATLAB bundles, as it only supports up to gcc version 9. To resolve this issue, it is advised to switch to gcc version 9 when compiling the QSpace library. This ensures compatibility between MATLAB's libstdc++ and the gcc compiler, avoiding such version-related errors.

## MEX files cannot be opened, developer cannot be verified

On newer versions of macOS, you may encounter an error stating that the developer of the MEX function binaries used by QSpace cannot be verified, preventing them from running. This is due to macOS security measures that block unverified software. To resolve this, use the following terminal commands to remove the quarantine attribute from the QSpace MEX files and add them to the approved list:

```bash
sudo xattr -r -d com.apple.quarantine $OSQS
# Use the following for intel-based Macs
sudo find $OSQS -name '*.mexmaci64' -exec spctl --add {} \;
# Use the following for Apple Silicon Macs
sudo find $OSQS -name '*.mexmaca64' -exec spctl --add {} \;
```

Ensure that the second command is entered as a single line. This approach modifies system security settings to trust the MEX files, allowing them to be executed without further prompts. For detailed guidance and additional information, please refer to [this FAQ page](http://www.fieldtriptoolbox.org/faq/mexmaci64_cannot_be_opened_because_the_developer_cannot_be_verified/).

## Invalid MEX file, Library not loaded

If you encountered the error showing "Invalid MEX-file [...] Library not loaded: /path/to/libgmp.10.dylib", followed by "mach-o file, but is an incompatible architecture (have ’arm64’, need ’x86_64’)", this indicates that QSpace is compiled for x86_64 architecture, while the gmp library is compiled for arm64 architecture.

This issue typically happens when running intel-compiled MATLAB on an Apple Silicon Mac. The MATLAB and QSpace binaries are compiled for x86_64 architecture, while the gmp library is installed by default for arm64 architecture. In this scenario, it is recommended to install arm64-compiled MATLAB (available from MATLAB 2023b onwards) to ensure compatibility with the system architecture.

If you still wish to use the intel-compiled MATLAB on an Apple Silicon Mac, you need to follow [these steps](/installation/macOS#install-homebrew) to set up an additional Homebrew installation under the Rosetta 2 emulation layer. This allows you to manage and install packages specifically for the intel architecture on Apple Silicon Macs. Make sure that the HOMEBREW_PREFIX is set to /usr/local, otherwise you need to adjust the path to the gmp library accordingly in the compile.sh script.

&nbsp;
