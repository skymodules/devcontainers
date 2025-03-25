#!/bin/bash

# build_folder: optional parameter to specify the folder to build
# If not specified, all folders will be built
# Example: ./test.sh ./alibaba
# Example: ./test.sh ./alibaba ./az
# Example: ./test.sh ./alibaba ./az ./aws
# Example: ./test.sh ./alibaba ./az ./aws ./gcp

# If no build_folder is specified, all folders will be built
if [ "$#" -eq 0 ]; then
    echo "No build folder specified. Building all folders."
    build_folders=(
        "./alibaba"
        "./az"
        "./aws"
        "./gcp"
        "./ibm"
        "./oci"
        "./tencent"
    )
else
    build_folders=("$@")
fi

# parameter 2: verbosity
# If not specified, verbosity is set to 0
# Example: ./test.sh ./alibaba 1
# Example: ./test.sh ./alibaba 2

# Set verbosity level
if [ "$#" -eq 2 ]; then
    verbosity=$2
else
    verbosity=0
fi

main() {

    for folder in "${build_folders[@]}"; do

        # if verbosity is set to 1, print the folder being built in detail
        if [ "$verbosity" -eq 1 ]; then
            echo "Building $folder"
            devcontainer build --workspace-folder "$folder" --config "$folder/devcontainer.json"
        else
            # Run the build command and capture success/failure
            if devcontainer build --workspace-folder "$folder" --config "$folder/devcontainer.json" >/dev/null 2>&1; then
                echo "$folder build success"
            else
                echo "$folder build fail"
            fi
        fi
    done
}

main "$@"
