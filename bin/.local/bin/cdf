#!/bin/bash
# count the number of files and dirs in current dir
shopt -s globstar
for file in **/*
do
  if [ -d "$file" ];then
    ((d++))
  elif [ -f "$file" ];then
     ((f++))
  fi
done
echo "Number of files: $f"
echo "Number of dirs: $d"
