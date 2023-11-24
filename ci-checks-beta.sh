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
    fi
done

# Loop through the errors array and echo each error
for error in "${errors[@]}"; do
    echo "Error: $error"
done