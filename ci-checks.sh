#!/bin/bash

# Array to store errors
errors=()

# Loop through each file path passed as an argument
for file_path in "$@"; do
    # Run black --check --diff on the file
    check_output=$(black --check --diff "$file_path" 2>&1)

    # Check if there are errors
    if [ $? -ne 0 ]; then
        # Add errors to the array
        errors+=("$check_output")

        # Generate GitHub annotation for each error
        IFS=$'\n' read -rd '' -a errors_array <<<"$check_output"
        for err in "${errors_array[@]}"; do
            IFS=: read -r line col message <<<"$err"
            echo "::error file=${file_path},line=${line},col=${col}::${message}"
        done
    fi
done

# Exit with a non-zero status code if there are errors
if [ ${#errors[@]} -gt 0 ]; then
    exit 1
fi
