#!/bin/bash

# Directory containing the JSON files
source_directory="/var/log/envoy/tap"

# Directory where the minified JSON file will be saved
target_directory="/var/log/envoy/tap/aggregated"
output_file="$target_directory/alltaps.json"

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Initialize the output file
touch "$output_file"

# Loop through each JSON file in the source directory
for file in "$source_directory"/*.json; do
    if [[ -f "$file" ]]; then
        echo "Processing file: $file"

        # Minify the JSON and append to the output file
        jq -c . "$file" >> "$output_file"
        rm -f "$file"

        echo "Minified JSON appended to: $output_file"
    else
        echo "No JSON files found in source directory."
    fi
done
