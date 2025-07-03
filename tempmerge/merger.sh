#!/bin/bash

i=0
path1=$1;
path2=$2
files1=("$path1"/*)
files2=("$path2"/*)

paddingLength=4
prefix=""
postfix=".png"

newDir="$1-$2"
if [ ! -d "$newDir" ]; then
    mkdir -p "$newDir";
fi;

count=0
nfiles=${#files1[@]}

echo "There are $nfiles files in directory:$1"

for ((i = 0; i < nfiles; i++)); 
  do
    cp ${files1[$i]} "$newDir"/$(printf $prefix%0${paddingLength}d$postfix $count)
    ((count=count+1))
    cp ${files2[$i]} "$newDir"/$(printf $prefix%0${paddingLength}d$postfix $count)
    ((count=count+1))
    echo "$count"
done
