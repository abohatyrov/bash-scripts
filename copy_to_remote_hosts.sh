#!/bin/bash

# Define the source and destination paths for the files
source_path="/path/to/source/files"
destination_path="/path/to/destination/files"

# Define the remote hosts and usernames to copy files to
hosts=("user1@remotehost1" "user2@remotehost2" "user3@remotehost3")

# Loop through each remote host and copy the files
for host in "${hosts[@]}"
do
  echo "Copying files to $host..."
  ssh "$host" "mkdir -p $destination_path && chmod 777 $destination_path"
  scp -r "$source_path" "$host:$destination_path"
done
