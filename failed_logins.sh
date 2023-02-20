#!/bin/bash
# For this script you need to install geoip-bin package for geoiplookup command

# Define the path to the auth.log file
auth_log="/var/log/auth.log"

# Parse the auth.log file and count the number of failed login attempts by IP address and location
failed_logins=$(grep "Failed password" "$auth_log" | awk '{print $(NF-3)}' | sort | uniq -c)

# Display the results
echo "Number of failed login attempts by IP address and location:"
echo "$failed_logins" | while read count ip_address; do
    location=$(geoiplookup "$ip_address" | awk -F ', ' '{print $2}')
    echo "  $count failed login attempts from $ip_address ($location)"
done
