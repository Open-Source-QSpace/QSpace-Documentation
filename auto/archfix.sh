# -----------------------------------------------------------
# Fix the GMP library path when using Intel MATLAB on an
# ARM Mac. This script is intended to be run after compiling.
# -----------------------------------------------------------

# < Description of Purpose >
# In the Intel compiled MATLAB, the GMP library path is for some
# reason hardcoded to /usr/local/homebrew/opt/gmp/lib/libgmp.10.dylib.
# This script changes the path to the correct path of the GMP library.

# Define the directory to search for .mexmaci64 files.
SEARCH_DIR=$(dirname "$(pwd)")

# Define the default path to the GMP library.
DEFAULT_LIB_PATH="/usr/local/homebrew/opt/gmp/lib/libgmp.10.dylib"
# Change this to the path of the GMP library on the system.
[[ -z "$GMP" ]] && export GMP="/usr/local/lib/libgmp.dylib"

# Check for the quiet flag
QUIET_MODE=0
if [[ "$1" == "-q" ]]; then
    QUIET_MODE=1
fi

# Find all .mexmaci64 files in the directory and its subdirectories
find "$SEARCH_DIR" -type f -name '*.mexmaci64' -print0 | while IFS= read -r -d '' file; do
    
    if [[ $QUIET_MODE -eq 0 ]]; then
        echo "Processing $file"
    fi

    # Use install_name_tool to change the library path
    install_name_tool -change "$DEFAULT_LIB_PATH" "$GMP" "$file"

    if [[ $? -ne 0 ]]; then
        # Print error message in red if not in quiet mode
        if [[ $QUIET_MODE -eq 0 ]]; then
            echo -e "$(tput setaf 1)(ERR) Failed to update library path for $file$(tput sgr0)"
        fi
    fi

done
