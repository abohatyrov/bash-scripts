#!/bin/bash

# Define the input and output files
input_file="/path/to/input.log"
output_file="/path/to/output.log"

# Define a function to parse the log file and extract the desired value with a timestamp
function parse_log_file() {
  local log_file="$1"
  local output_file="$2"
  local value_to_parse="$3"
  while read -r line; do
    timestamp=$(echo "$line" | awk '{print $1, $2}')
    value=$(echo "$line" | grep -o "$value_to_parse=[^ ]*" | cut -d= -f2)
    if [ -n "$value" ]; then
      echo "$timestamp $value" >> "$output_file"
    fi
  done < "$log_file"
}

# Call the function to parse the input file and write the desired value with a timestamp to the output file
parse_log_file "$input_file" "$output_file" "desired_value"

# Display a message indicating the output file location
echo "Output written to $output_file"
