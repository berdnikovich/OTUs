#!/bin/bash
####this code rename all files for mothur format
input="/home/berdnikovich/task/trimmed_galoread"


for file1 in $input/*.fq.gz
do
    basein1=${file1%_paired_*}
    basein3=${basein1#*$input/}
    basein4=${basein3#*_}
    if [[ "$basein4" == "forward" ]]; then
        basein5=${basein3%_forward*}
        mv "$file1" "$input/${basein5}_R1.fq.gz"
    elif [[ "$basein4" == "reverse" ]]; then
        basein5=${basein3%_reverse*}
        mv "$file1" "$input/${basein5}_R2.fq.gz"
    fi
done