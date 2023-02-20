#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Please specify the date in the format YYYY-MM-DD."
  exit 1
fi

date="$1"
output_file="users_logged_in_${date}.txt"

echo "Users logged in on ${date}:" > "${output_file}"
echo "===========================" >> "${output_file}"

last | grep "^.* ${date}" | awk '{print $1}' | sort | uniq >> "${output_file}"

echo "Output written to ${output_file}."
