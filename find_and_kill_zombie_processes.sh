#!/bin/bash

ALL_PIDS=$(ps aux | egrep "Z|defunct" | awk '{print $2}' | ps -o ppid=)
declare PIDS=''

for PID in $ALL_PIDS; do
  if [[ ! $PIDS =~ $PID ]] ; then 
    PIDS="$PIDS $PID"
  fi
done
PIDS=${PIDS:1} 

for PID in $PIDS; do
  if ps -p $PID > /dev/null; then
    kill -s SIGCHLD $PID
  fi
done
echo "Zombie processes has been deleted!"

read -p "Do you want to kill parent processes? (y/N): " KILL_PARENT

if [[ $KILL_PARENT == "y" ]]; then
  echo "Deleting..."
  for PID in $PIDS; do
    if ps -p $PID > /dev/null; then
      kill -9 $PIDS
    fi
  done
  echo "Parents has been deleted!"
fi

