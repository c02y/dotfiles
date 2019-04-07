#!/bin/bash 
# go through all your files in the current dir and print if it found a blank line 
# at the beginning or end of each file:
for f in `find . -type f `; do 
  for t in head tail; do 
    $t -1 $f  |egrep '^[  ]*$' >/dev/null && echo "blank line at the $t of $f"; 
  done; 
done
