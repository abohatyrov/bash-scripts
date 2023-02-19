#!/bin/bash

# Output file path
output_file="/path/to/output.txt"

# Header row for the output file
echo "DATE | TIME | CPU % | MEM % | DISK %" > "$output_file"

# Monitor CPU, memory, and disk usage every 10 seconds
while true; do
  # Get the current date and time
  date=$(date +"%Y-%m-%d")
  time=$(date +"%H:%M:%S")

  # Get the CPU and memory usage using top command
  cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
  mem=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2}')

  # Get the disk usage using df command
  disk=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')

  # Write the data to the output file
  echo "${date} | ${time} | ${cpu}% | ${mem} | ${disk}" >> "$output_file"

  # Wait for 10 seconds before monitoring again
  sleep 10
done
