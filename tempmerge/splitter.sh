#!/bin/bash

paddingLength=4
prefix=""
postfix=".png"

dir1="1"
if [ ! -d "$dir1" ]; then
    mkdir -p "$dir1";
fi;

dir2="2"
if [ ! -d "$dir1" ]; then
    mkdir -p "$dir1";
fi;

del=1
for fspec in *.* ; do
    if [[ ${del} -eq 1 ]] ; then
        del=0
        rm ${fspec}
    else
        echo ok ${fspec}
        del=1
    fi
done

count=0

del=1
for fspec in *.* ; do
    if [[ ${del} -eq 1 ]] ; then
        del=0
        mv ${fspec} "$dir1"/$(printf $prefix%0${paddingLength}d$postfix $count)
    else
        
        mv ${fspec} "$dir2"/$(printf $prefix%0${paddingLength}d$postfix $count)
        del=1
    fi

  ((count=count+1))
  echo "$count"
done

