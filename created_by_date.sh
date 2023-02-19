#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Please specify the number of days or the from and to dates."
  exit 1
fi

if [ $# -eq 1 ]; then
  # Find files created within the last n days
  num_days=$1
  find_cmd="find . -type f -mtime -${num_days}"
else
  # Find files created between two dates
  from_date=$1
  to_date=$2
  find_cmd="find . -type f -newermt '${from_date}' ! -newermt '${to_date}'"
fi

# Run the find command and output the filenames and sizes
echo "Files created within specified time range:"
echo "========================================="
$find_cmd -printf "%s %p\n" | while read size filename; do
  echo "${filename} - ${size} bytes"
done
