#!/bin/bash

# $1 - path to directory
# $2 - file to save output
# sudo ./script.sh /path/to/dir/ output.txt

re='^[0-9]+$'
FILES=$(find $1 -type f -printf '%s %p\n'| sort -nr | head -10)

for item in $FILES; do
  if [[ $item =~ $re ]]; then
    echo -n "[+] Size: $item; " >> $2
  else
    echo "File: $item [+]" >> $2
    cat $item >> $2
    echo >> $2 
  fi
done
