#!/bin/bash

# Check if an argument is provided
if [ "$#" -eq 0 ]; then
  echo "Error: Please provide a directory name as an argument."
  exit 1
fi

# Extract the directory name from the argument
dir_name="$1"

# Check if the directory exists
if [ ! -d "$dir_name" ]; then
  echo "Error: Directory '$dir_name' does not exist."
  exit 1
fi

# Change to the specified directory
cd "$dir_name" || exit 1


# Replace hyphens with underscores in the directory name
function_name=$(echo "$dir_name" | tr '-' '_')

if [ -d "package" ]; then rm -Rf package; fi

mkdir package

# Install packages into target
pip install \
--platform manylinux2014_aarch64 \
--target=package \
--implementation cp \
--python-version 3.10 \
--only-binary=:all: --upgrade \
-r requirements.txt

# Clean and zip packages and source code

if [ -f "${function_name}.zip" ]; then rm ${function_name}.zip; fi

cd package
zip -r ../${function_name}.zip .
cd ..
zip ${function_name}.zip lambda_function.py

# Update function definition
response=$(aws lambda update-function-code \
--region eu-central-1 \
--no-dry-run \
--function-name ${function_name} \
--zip-file fileb://${function_name}.zip)
