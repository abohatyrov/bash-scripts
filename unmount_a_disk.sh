#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 [mount-point]"
  exit 1
fi

MOUNT_POINT=$1

if [ ! -d $MOUNT_POINT ]; then
  echo "Error: $MOUNT_POINT is not a valid directory"
  exit 1
fi

if ! mount | grep -q $MOUNT_POINT; then
  echo "Error: $MOUNT_POINT is not currently mounted"
  exit 1
fi

echo "Unmounting $MOUNT_POINT..."
umount -l $MOUNT_POINT
echo "Done"
